//
//  BreadcrumbView.swift
//  BreadCrumbHeaders
//
//  Created by Inder Dhir on 6/24/18.
//

class BreadcrumbView: UIView {

    private let totalCount: Int
    let headers: [String]
    var breadcrumbsBackground: UIColor
    var straightBeginning: Bool
    var straightEnd: Bool
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
        totalCount: Int,
        widthOfArrow: CGFloat,
        spacingBetweenItems: CGFloat,
        itemCompleteColor: UIColor,
        itemIncompleteColor: UIColor
        ) {

        self.headers = headers
        self.breadcrumbsBackground = breadcrumbsBackground
        self.straightBeginning = straightBeginning
        self.straightEnd = straightEnd
        self.totalCount = totalCount
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
        breadcrumbsBackground.setFill()
        UIRectFill(rect)

        let interval = 1 / CGFloat(totalCount)
        let midPointY = (rect.minY + rect.maxY) * 0.5
        var drawRatio: CGFloat = 0
        var spacing: CGFloat
        for index in 0..<totalCount {
            spacing = index == 0 ? 0 : spacingBetweenItems

            if index == totalCount - 1 {
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
            if index == totalCount - 1 && straightEnd {
                path.addLine(to: CGPoint(x: arrowEndX, y: rect.minY))
                path.addLine(to: CGPoint(x: arrowEndX, y: rect.maxY))
            } else {
                path.addLine(to: CGPoint(x: arrowStartX, y: rect.minY))
                path.addLine(to: CGPoint(x: arrowEndX, y: midPointY))
                path.addLine(to: CGPoint(x: arrowStartX, y: rect.maxY))
            }
            path.addLine(to: CGPoint(x: startingX, y: rect.maxY))
            if index != 0 || (index == 0 && !straightBeginning) {
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
