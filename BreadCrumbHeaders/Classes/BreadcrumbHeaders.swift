//
//  BreadcrumbHeaders.swift
//  BreadcrumbHeaders
//
//  Created by Inder Dhir on 06/24/2018.
//  Copyright (c) 2018 Inder Dhir. All rights reserved.
//

import UIKit

public class BreadcrumbHeaders: UIView {

    public var breadcrumbsBackground = UIColor.white {
        didSet {
            breadcrumbView.breadcrumbsBackground = breadcrumbsBackground
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var straightBeginning = true {
        didSet {
            breadcrumbView.straightBeginning = straightBeginning
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var straightEnd = false {
        didSet {
            breadcrumbView.straightEnd = straightEnd
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var widthOfArrow: CGFloat = 5 {
        didSet {
            breadcrumbView.widthOfArrow = widthOfArrow
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var spacingBetweenItems: CGFloat = 2 {
        didSet {
            breadcrumbView.spacingBetweenItems = spacingBetweenItems
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var count: Int { return headers.count }

    public var selectedIndex = 0 {
        didSet {
            guard selectedIndex < count else {
                fatalError("Selected index is out of bounds")
            }

            breadcrumbView.selectedIndex = selectedIndex
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var itemCompleteColor = UIColor.black {
        didSet {
            breadcrumbView.itemCompleteColor = itemCompleteColor
            breadcrumbView.setNeedsDisplay()
        }
    }

    public var itemIncompleteColor = UIColor.gray {
        didSet {
            breadcrumbView.itemIncompleteColor = itemIncompleteColor
            breadcrumbView.setNeedsDisplay()
        }
    }

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

    public init(
        headers: [String],
        headerLabel: (() -> UILabel)? = nil
        ) {
        self.headers = headers
        breadcrumbView = BreadcrumbView(
            headers: headers,
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

        addSubview(breadcrumbView)
        headers.forEach { [weak self] header in
            let addedView = headerLabel?() ?? constructView()
            addedView.text = header
            addSubview(addedView)
            self?.addedViews.append(addedView)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    private func setupConstraints() {
        breadcrumbView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadcrumbView.leadingAnchor.constraint(equalTo: leadingAnchor),
            breadcrumbView.trailingAnchor.constraint(equalTo: trailingAnchor),
            breadcrumbView.topAnchor.constraint(equalTo: topAnchor),
            breadcrumbView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let width: CGFloat = bounds.width * (1 / CGFloat(count))
        var lastAddedView: UIView?
        addedViews.forEach { addedView in
            addedView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addedView.leadingAnchor.constraint(
                    equalTo: lastAddedView?.trailingAnchor ?? leadingAnchor
                ),
                addedView.widthAnchor.constraint(equalToConstant: width),
                addedView.heightAnchor.constraint(equalTo: heightAnchor),
                addedView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])

            lastAddedView = addedView
        }
    }

    private func constructView() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
}
