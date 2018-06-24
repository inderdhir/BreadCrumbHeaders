

// TODO: Model this better
enum BreadcrumbFill {
    case oneThird, twoThird, all
}

public class BreadcrumbHeaders: UIView {

    public var straightEnd = false {
        didSet { setNeedsDisplay() }
    }

    private let breadcrumbView: BreadcrumbView

    private func headerLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }

    private var headers: [String]!

    public static func initWithHeaders(_ headers: [String])
        -> BreadcrumbHeaders {
            let view = BreadcrumbHeaders(headers: headers)
            return view
    }

    private var labelOne: UILabel!
    private var labelTwo: UILabel!
    private var labelThree: UILabel!

    var fill = BreadcrumbFill.oneThird {
        didSet {
            breadcrumbView.fill = fill

            if fill == .all {
                labelThree.textColor = .black
                labelTwo.textColor = .black
                labelOne.textColor = .black
            } else if fill == .twoThird {
                labelThree.textColor = .lightGray
                labelTwo.textColor = .black
                labelOne.textColor = .black
            } else {
                labelThree.textColor = .lightGray
                labelTwo.textColor = .lightGray
                labelOne.textColor = .black
            }
            setNeedsDisplay()
        }
    }

    init(headers: [String]) {
        self.headers = headers
        breadcrumbView = BreadcrumbView(straightEnd: straightEnd)

        super.init(frame: .zero)

        addSubview(breadcrumbView)

        labelOne = headerLabel()
//        labelOne.backgroundColor = .blue
        labelOne.text = headers[0].uppercased()
        addSubview(labelOne)

        labelTwo = headerLabel()
        labelTwo.text = headers[1].uppercased()
        addSubview(labelTwo)

        labelThree = headerLabel()
        labelThree.text = headers[2].uppercased()
        addSubview(labelThree)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        setupConstraints()
    }

    private func setupConstraints() {
        guard superview != nil else {
            fatalError("\(String(describing: self)) is missing a superview")
        }

        let width: CGFloat = bounds.width * 0.33

        breadcrumbView.translatesAutoresizingMaskIntoConstraints = false
        breadcrumbView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        breadcrumbView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        breadcrumbView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        breadcrumbView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        labelOne.widthAnchor.constraint(equalToConstant: width).isActive = true
        labelOne.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelOne.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelOne.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.leadingAnchor.constraint(equalTo: labelOne.trailingAnchor).isActive = true
        labelTwo.widthAnchor.constraint(equalToConstant: width).isActive = true
        labelTwo.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelTwo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelTwo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        labelThree.translatesAutoresizingMaskIntoConstraints = false
        labelThree.leadingAnchor.constraint(equalTo: labelTwo.trailingAnchor).isActive = true
        labelThree.widthAnchor.constraint(equalToConstant: width).isActive = true
        labelThree.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelThree.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelThree.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

private class BreadcrumbView: UIView {

    private let straightEnd: Bool

    init(straightEnd: Bool) {
        self.straightEnd = straightEnd
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var fill = BreadcrumbFill.oneThird {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {

        UIColor.white.setFill()
        UIRectFill(rect)

        // 1/3

        let path = UIBezierPath()
        var drawRatio: CGFloat = 0.33
        UIColor.black.setFill()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * drawRatio + 5, y: (rect.minY + rect.maxY) * 0.5))
        path.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        path.close()
        path.fill()

        // 2/3

        let startingPointTwo = (rect.maxX * drawRatio) + 2
        let pathTwo = UIBezierPath()
        if fill == .twoThird || fill == .all {
            UIColor.black.setFill()
        } else {
            UIColor.lightGray.setFill()
        }
        drawRatio = 0.66

        pathTwo.move(to: CGPoint(x: startingPointTwo, y: rect.minY))
        pathTwo.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.minY))
        pathTwo.addLine(to: CGPoint(x: (rect.maxX * drawRatio) + 5,
                                    y: (rect.minY + rect.maxY) * 0.5))
        pathTwo.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.maxY))
        pathTwo.addLine(to: CGPoint(x: startingPointTwo, y: rect.maxY))
        pathTwo.addLine(to: CGPoint(x: startingPointTwo + 5, y: (rect.minY + rect.maxY) * 0.5))

        pathTwo.close()
        pathTwo.fill()

        // 3/3

        let startingPointThree = (rect.maxX * drawRatio) + 2
        let pathThree = UIBezierPath()
        if fill == .all {
            UIColor.black.setFill()
        } else {
            UIColor.lightGray.setFill()
        }
        drawRatio = 1.0

        pathThree.move(to: CGPoint(x: startingPointThree, y: rect.minY))
        if straightEnd {
            pathThree.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.minY))
            pathThree.addLine(to: CGPoint(x: rect.maxX * drawRatio, y: rect.maxY))
        } else {
            pathThree.addLine(to: CGPoint(x: (rect.maxX * drawRatio) - 5, y: rect.minY))
            pathThree.addLine(to: CGPoint(x: rect.maxX * drawRatio,
                                          y: (rect.minY + rect.maxY) * 0.5))
            pathThree.addLine(to: CGPoint(x: (rect.maxX * drawRatio) - 5,
                                          y: rect.minY + rect.maxY))
        }
        pathThree.addLine(to: CGPoint(x: startingPointThree, y: rect.maxY))
        pathThree.addLine(to: CGPoint(x: startingPointThree + 5, y: (rect.minY + rect.maxY) * 0.5))

        pathThree.close()
        pathThree.fill()
    }
}

