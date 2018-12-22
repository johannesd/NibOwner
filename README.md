# NibOwner

This code provides you with some helper functions for working with NIBs. The **Background** section below gives you some information about how NIBs work.

## Background

Using NIBs (or storyboards) is a convenient way to create designs for ViewControllers and TableView and CollectionView cells. However, using NIBs for a regular UIView subclass is not so easy to understand. Apple has not streamlined the process, for some reason. Here is one thing that I observed: When adding a new file (File -> New -> File... -> Cocoa Touch Class) in XCode and set `UIView` as base class, the "Also create XIB file" checkbox is grayed out. Why is that? On the other hand, why is the option available when creating a `UITableViewCell` subclass? Creating a reusable view should be a no-brainer, not only for cells. 

There are quite some suggestions on Stack Overflow, but since they looked ugly to me, I decided to dive a bit deeper into the topic.

### How XIBs/NIBs work

In order to create a view from a NIB, you typically use something like `Bundle.main.loadNibNamed("MyView", owner: nil, options: nil)`. This function is using the same API that you can use to (de)serialize classes: The `NSCoding` protocol. It is a universal concept: Any class that conforms to that protocol can be stored as JSON or XML, and be loaded again later, which would restore the complete state, i.e. the properties. If you don't know `NSCoding`, you might now `Codable`, which is similar (but better) and has been introduced in Swift 4. A typical use case is storing application data in a struct and then encoding it as a JSON in order to save it as a text file. When the app launches the next time, the JSON can be decoded to get the original struct with all its contents back.

You can do the same with UIViews, beause it conforms to `NSCodable`. While you probably never have thougt of saving a view as a file, you probably have loaded views from a file a many times before: every time you have been using a XIB or NIB. A NIB file is basically the encoded version of a view, that can be decoded at runtime. When that happens, all properties of the view, like background color, frame, subviews, etc. will be set.

Have you ever wondered why the compiler forces you to implement `init(coder:)` whenever you create a custom initializer? That is because of `Codable`. The protocol has a required initializer that all classes must have. Since implementing an initializer in a subclass hides all initializers of the super class, you have to add that required initializer again to make sure it is available. Otherwise, the class would not be decodable. 

When decoding a class, that special initializer is used by the decoder, no matter what other initializers your class has. This will be important later.

### How it should be, and why it is not like that

Now, back to building a reusable view using a XIB. Here is what we want:

- **Use in other NIB or storyboard** It should be possible to use the view in other parts of the UI that we design using Interface Builder. For some reason, Apple does not support nested NIBs, although this would be a great feature.
- **Use in code with initializer** Decoding the view is possible using `loadNibNamed(:owner:options)` mentioned above. But just like any other view, we would like to create the instance with a normal initializer, like `MyView(frame:)`. The fact that we have created the view using a NIB is an implementation detail. So, any programmer who uses our view should be able to create an instance in a straight-forward way, which is also consistent to other classes like `UITableView(frame:)` etc. Furthermore, initializers are a great way to provide essential information to the class. If you cannot provide a custom initializer, you lose that opportunity. 

And here is why it does not work:

- In order to use a custom view class in a ViewController NIB or storyboard, you add a create regular view and insert your custom class' name into the *Custom class* field. This only works for views completely written in code, though. Why? Well, when that ViewController NIB is loded and your custom view is about to be initialized, the `init(coder:)` initializer of your custom class is called with the content from the ViewController, and not from your custom view NIB. The view will use the custom class, but the subviews will not be there, and the outlets will not be set.
- In order to create your custom view using an initializer like `MyView(frame:)`, we would have to implement that initializer in a way that it uses `loadNibNamed(:owner:options)` to load the nib, and then return that object. But that's not how initializers work. By the time init is called, the object has already be created. We cannot replace it with another object. If Swift ever introduces *factory initializers*, those could be a solution for that.  

### Why does it work with ViewControllers?

When creating the UI for a ViewController, this problem does not appear. We set the ViewController class as *File Owner*, and edit the view as we like. The difference here is that the decoded object is not the ViewController, but the view. So, when the ViewController instance is created, the corresponding view is created from the NIB.

### Conclusion 

- For reusing views, Apple focuses on TableView and CollectionView. Those APIs also offer view reusage for best performance, so use that if possible.
- The reuse behavior in TableView and CollectionView made me realize that custom initializers with parameters might not be a good idea for view anyway, because they break such reuse behaviour. When the view is going to be reused, all parameters must be changable. So, all parameters handed over to the constructor should be available as changable property, anyway.
- Are you building a view with many controls, like buttons etc.? Maybe this component should be implemented as a ViewController, and you can perfectly use a NIB for that.
- Implement small views in pure code. A NIB would be overhead, and not worth the hussle.
- For all other cases where you definitely need a regular view and want to design it using a NIB, use this librabry. A good example would be a TableHeaderView.   

## Usage

In order to create a View called *ExampleView*, create a file called ExampleView.swift: 

```swift
public class ExampleView: UIView, NibOwner {
    @IBOutlet weak var subView: UIView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
```

Adding `init?(coder:)` is not required, but hides all other initializers, like `init(frame:)`. This initializer would not use your XIB, so you should make sure that another programmer is not tempted to use that wrong initialier.  

Create a XIB file. Change the custom class name of the root view to *ExampleView*. Don't set *File Owner*. Create outlets using drag and drop in the Assistent Editor.

In order to use the view in code, write:  

```swift
let view = ExampleView.fromNib()
```

In order to use the view from a NIB or storyboard, you have to create a wrapper class. Or you see it the other way around: The view you create must be writte in pure code. But it can internally insert a subview that you create using a NIB. Just set the root view's class of that NIB to `InnerExampleView`.

```swift
internal class InnerExampleView: UIView, NibOwner {
    @IBOutlet weak var subView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

public class CompoundExampleView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertInnerView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertInnerView()
    }
    
    func insertInnerView() {
        let innerView = InnerExampleView.fromNib()!
        addSubview(innerView)
        // TODO: add layout constraints
    }
}
```

After designing the inner view (`InnerExampleView`) as a NIB, you might want to access the outlets from the outer view (`CompoundExampleView`). While that is perfectly possible by writing something like `innerView.subView`, you might prefer to have those outlets as properties of the outer class, not the inner class. In order to achieve that, go to the NIB file and set the *File Owner* to `CompoundExampleView`. Now, we can drag the outlets to the outer view. 

```swift
internal class InnerExampleView: UIView, NibOwner {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

public class CompoundExampleView: UIView {
    @IBOutlet weak var subView: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertInnerView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertInnerView()
    }

    func insertInnerView() {
        let innerView = InnerExampleView.fromNib(owner: self)!
        addSubview(innerView)
        // TODO: add layout constraints
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

NibOwner is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NibOwner'
```

## Author

Johannes Dörr, mail@johannesdoerr.de

## License

NibOwner is available under the MIT license. See the LICENSE file for more info.
