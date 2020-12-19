//
//  BreadcrumbView.swift
//  BreadCrumbHeaders
//
//  Created by Inder Dhir on 6/24/18.
//

import UIKit
import Foundation

final class BreadcrumbView: UIView {

    let headers: [String]
    var spacingBackgroundColor: UIColor
    var isArrowAtStartEnabled: Bool
    var isArrowAtEndEnabled: Bool
    var widthOfArrow: CGFloat
    var spacingBetweenItems: CGFloat
    var selectedIndex: Int
    var itemCompleteColor: UIColor
    var itemIncompleteColor: UIColor

    init(
        headers: [String],
        breadcrumbsBackground: UIColor,
        straightBeginning: Bool,
        straightEnd: Bool,
        widthOfArrow: CGFloat,
        spacingBetweenItems: CGFloat,
        itemCompleteColor: UIColor,
        itemIncompleteColor: UIColor
        ) {

        self.headers = headers
        self.spacingBackgroundColor = breadcrumbsBackground
        self.isArrowAtStartEnabled = straightBeginning
        self.isArrowAtEndEnabled = straightEnd
        self.widthOfArrow = widthOfArrow
        self.spacingBetweenItems = spacingBetweenItems
        self.itemCompleteColor = itemCompleteColor
        self.itemIncompleteColor = itemIncompleteColor
        selectedIndex = 0

        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        spacingBackgroundColor.setFill()
        UIRectFill(rect)

        let interval = 1 / CGFloat(headers.count)
        let midPointY = (rect.minY + rect.maxY) * 0.5
        var drawRatio: CGFloat = 0
        var spacing: CGFloat
        for index in 0..<headers.count {
            spacing = index == 0 ? 0 : spacingBetweenItems

            if index == headers.count - 1 {
                drawRatio = 1
            } else {
                drawRatio += interval
            }

            if selectedIndex >= index {
                itemCompleteColor.setFill()
            } else {
                itemIncompleteColor.setFill()
            }

            let path = UIBezierPath()
            let startingX = index == 0 ?
                (rect.minX) :
                ((rect.maxX * drawRatio) - (rect.maxX * interval)) - widthOfArrow + spacing
            let arrowStartX = (rect.maxX * drawRatio) - widthOfArrow
            let arrowEndX = arrowStartX + widthOfArrow

            path.move(to: CGPoint(x: startingX, y: rect.minY))
            if index == headers.count - 1 && !isArrowAtEndEnabled {
                path.addLine(to: CGPoint(x: arrowEndX, y: rect.minY))
                path.addLine(to: CGPoint(x: arrowEndX, y: rect.maxY))
            } else {
                path.addLine(to: CGPoint(x: arrowStartX, y: rect.minY))
                path.addLine(to: CGPoint(x: arrowEndX, y: midPointY))
                path.addLine(to: CGPoint(x: arrowStartX, y: rect.maxY))
            }
            path.addLine(to: CGPoint(x: startingX, y: rect.maxY))
            if index != 0 || (index == 0 && isArrowAtStartEnabled) {
                path.addLine(
                    to: CGPoint(
                        x: startingX + widthOfArrow,
                        y: midPointY
                    )
                )
            }

            path.close()
            path.fill()
        }
    }
}
