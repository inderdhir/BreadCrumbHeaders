//
//  BreadcrumbHeaders.swift
//  BreadcrumbHeaders
//
//  Created by Inder Dhir on 06/24/2018.
//  Copyright (c) 2018 Inder Dhir. All rights reserved.
//

public class BreadcrumbHeaders: UIView {

    // Public properties

    public var breadcrumbsBackground = UIColor.white {
        didSet {
            breadcrumbView.breadcrumbsBackground = breadcrumbsBackground
            setNeedsDisplay()
        }
    }

    public var straightBeginning = true {
        didSet {
            breadcrumbView.straightBeginning = straightBeginning
            setNeedsDisplay()
        }
    }

    public var straightEnd = false {
        didSet {
            breadcrumbView.straightEnd = straightEnd
            setNeedsDisplay()
        }
    }

    public var widthOfArrow: CGFloat = 5 {
        didSet {
            breadcrumbView.widthOfArrow = widthOfArrow
            setNeedsDisplay()
        }
    }

    public var spacingBetweenItems: CGFloat = 2 {
        didSet {
            breadcrumbView.spacingBetweenItems = spacingBetweenItems
            setNeedsDisplay()
        }
    }

    public var selectedIndex: Int = 0 {
        didSet {
            guard selectedIndex < headers.count else {
                fatalError("Selected index is out of bounds")
            }

            breadcrumbView.selectedIndex = selectedIndex
            setNeedsDisplay()
        }
    }

    public var itemCompleteColor: UIColor = .black {
        didSet {
            breadcrumbView.itemCompleteColor = itemCompleteColor
            setNeedsDisplay()
        }
    }

    public var itemIncompleteColor: UIColor = .gray {
        didSet {
            breadcrumbView.itemIncompleteColor = itemIncompleteColor
            setNeedsDisplay()
        }
    }

    // Private

    private let breadcrumbView: BreadcrumbView

    private func headerLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }

    private let headers: [String]
    private var addedViews: [UIView] = []

    private func constructView() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }

    public init(headers: [String]) {
        self.headers = headers
        breadcrumbView = BreadcrumbView(
            breadcrumbsBackground: breadcrumbsBackground,
            straightBeginning: straightBeginning,
            straightEnd: straightEnd,
            totalCount: headers.count,
            widthOfArrow: widthOfArrow,
            spacingBetweenItems: spacingBetweenItems,
            itemCompleteColor: itemCompleteColor,
            itemIncompleteColor: itemIncompleteColor
        )

        super.init(frame: .zero)
        isUserInteractionEnabled = false

        addSubview(breadcrumbView)
        for header in headers {
            let addedView = constructView()
            addedView.text = header
            addSubview(addedView)
            addedViews.append(addedView)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func setupConstraints() {
        breadcrumbView.translatesAutoresizingMaskIntoConstraints = false
        breadcrumbView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        breadcrumbView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        breadcrumbView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        breadcrumbView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        let width: CGFloat = bounds.width * (1 / CGFloat(headers.count))
        var lastAddedView: UIView?
        for addedView in addedViews {
            addedView.translatesAutoresizingMaskIntoConstraints = false
            addedView.leadingAnchor.constraint(
                equalTo: lastAddedView?.trailingAnchor ?? leadingAnchor
            ).isActive = true
            addedView.widthAnchor.constraint(equalToConstant: width).isActive = true
            addedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            addedView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            addedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

            lastAddedView = addedView
        }
    }
}
