//
//  BreadcrumbHeaders.swift
//  BreadcrumbHeaders
//
//  Created by Inder Dhir on 06/24/2018.
//  Copyright (c) 2018 Inder Dhir. All rights reserved.
//

import UIKit

/// Draws breadcrumbs with header labels on top on them
public class BreadcrumbHeaders: UIView {

    /// Total breadcrumb count
     public let count: Int

    /// Background for the breadcrumbs. This is the color that will show up if there are gaps between them
    public var spacingBackgroundColor = UIColor.white {
        didSet {
            breadcrumbView.spacingBackgroundColor = spacingBackgroundColor
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Whether the first breadcrumb has an arrow at the start (like the end). Default: false
    public var isArrowAtStartEnabled = false {
        didSet {
            breadcrumbView.isArrowAtStartEnabled = isArrowAtStartEnabled
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Whether the breadcrumbs have an arrow at the end. Default: true
    public var isArrowAtEndEnabled = true {
        didSet {
            breadcrumbView.isArrowAtEndEnabled = isArrowAtEndEnabled
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Width of the arrow at the start(if enabled) end for the breadcrumbs. Default: 5
    public var widthOfArrow: CGFloat = 5 {
        didSet {
            breadcrumbView.widthOfArrow = widthOfArrow
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Spacing between the breadcrumbs. Default: 2
    public var spacingBetweenItems: CGFloat = 2 {
        didSet {
            breadcrumbView.spacingBetweenItems = spacingBetweenItems
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Selected index for the breadcrumbs. Default: 0
    public var selectedIndex = 0 {
        didSet {
            guard selectedIndex < headers.count else {
                fatalError("Selected index is out of bounds")
            }

            breadcrumbView.selectedIndex = selectedIndex
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Background color for a completed breadcrumb. Default: UIColor.black
    public var itemCompleteColor = UIColor.black {
        didSet {
            breadcrumbView.itemCompleteColor = itemCompleteColor
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// Background color for an incomplete breadcrumb. Default: UIColor.gray
    public var itemIncompleteColor = UIColor.gray {
        didSet {
            breadcrumbView.itemIncompleteColor = itemIncompleteColor
            breadcrumbView.setNeedsDisplay()
        }
    }

    /// View to draw the breadcrumbs
    private let breadcrumbView: BreadcrumbView

    /// UILabel Template to draw the headers.
    private func headerLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }

    /// Header names
    private let headers: [String]

    /// Keeps track of the header labels for positioning
    private var headerLabels: [UIView] = []

    public init(
        headers: [String],
        headerLabel: (() -> UILabel)? = nil
        ) {
        self.headers = headers
        self.count = headers.count
        breadcrumbView = BreadcrumbView(
            headers: headers,
            breadcrumbsBackground: spacingBackgroundColor,
            straightBeginning: isArrowAtStartEnabled,
            straightEnd: isArrowAtEndEnabled,
            widthOfArrow: widthOfArrow,
            spacingBetweenItems: spacingBetweenItems,
            itemCompleteColor: itemCompleteColor,
            itemIncompleteColor: itemIncompleteColor
        )

        super.init(frame: .zero)

        addSubview(breadcrumbView)
        headers.forEach { [weak self] header in
            let addedView = headerLabel?() ?? self?.headerLabel()
            guard let labelView = addedView  else { return }
            labelView.text = header
            addSubview(labelView)
            self?.headerLabels.append(labelView)
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

        let width: CGFloat = bounds.width * (1 / CGFloat(headers.count))
        var lastAddedView: UIView?
        headerLabels.forEach { addedView in
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
}
