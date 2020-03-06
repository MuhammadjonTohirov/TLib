//
//  TSegmentedController.swift
//  Based on BetterSegmentedController github :)
//  wtp
//
//  Created by muhammadjon on 07/11/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

public enum TSegmentedControlOption {
    /* Selected segment */
    case indicatorViewBackgroundColor(UIColor)
    case indicatorViewInset(CGFloat)
    case indicatorViewBorderWidth(CGFloat)
    case indicatorViewBorderColor(UIColor)
    case indicatorBottomViewColor(UIColor)
    
    /* Behavior */
    case alwaysAnnouncesValue(Bool)
    case announcesValueImmediately(Bool)
    case panningDisabled(Bool)
    
    /* Other */
    case backgroundColor(UIColor)
    case cornerRadius(CGFloat)
    case bouncesOnChange(Bool)
}


public protocol TSegmentedControlSegment {
    var normalView: UIView { get }
    var selectedView: UIView { get }
}

open class TSIndicatorView: UIView {
    
    public enum TSIndicatorStyle {
        case bottomLine
        case coverBody
    }
    
    // MARK: Properties
    fileprivate let segmentMaskView = UIView()
    fileprivate let bottomView = UIView()
    public var type: TSIndicatorStyle = .coverBody
    
    fileprivate var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            segmentMaskView.layer.cornerRadius = cornerRadius
        }
    }
    override open var frame: CGRect {
        didSet {
            segmentMaskView.frame = frame
            
            let x: CGFloat = 8
            let h: CGFloat = type == .bottomLine ? 4 : 0
            let w = size.width - 2 * x
            let y = size.height - h
            bottomView.frame = CGRect(x: x, y: y, width: w, height: h)
            
            if type == .bottomLine {
                segmentMaskView.height = segmentMaskView.height - h
            }
        }
    }
    
    open override var backgroundColor: UIColor? {
        didSet {
            if type == .bottomLine {
                self.segmentMaskView.backgroundColor = .clear
            }
        }
    }
    
    init(style: TSIndicatorStyle = .coverBody) {
        super.init(frame: .zero)
        self.type = style
        finishInit()
    }
    
    // MARK: Lifecycle
    init() {
        super.init(frame: CGRect.zero)
        finishInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finishInit()
    }
    private func finishInit() {
        if type == .bottomLine {
            self.addSubview(bottomView)
            self.bottomView.backgroundColor = .brown
        }
        
        self.layer.masksToBounds = true
        self.segmentMaskView.backgroundColor = .black
    }
}


@IBDesignable open class TSegmentedControl: UIControl {
    
    // MARK: Constants
    private struct Animation {
        static let withBounceDuration: TimeInterval = 0.3
        static let springDamping: CGFloat = 0.75
        static let withoutBounceDuration: TimeInterval = 0.2
    }
        
    // MARK: Properties
    /// The selected index.
    public private(set) var index: Int
    /// The segments available for selection.
    public var segments: [TSegmentedControlSegment] {
        didSet {
            guard segments.count > 1 else {
                return
            }
            
            normalSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            selectedSegmentsView.subviews.forEach({ $0.removeFromSuperview() })
            
            for segment in segments {
                normalSegmentsView.addSubview(segment.normalView)
                selectedSegmentsView.addSubview(segment.selectedView)
            }
            
            setNeedsLayout()
        }
    }
    
    /// The currently selected index indicator view.
    public var indicatorView: TSIndicatorView
    
    /// A list of options to configure the control with.
    public var options: [TSegmentedControlOption]? {
        get { return nil }
        set {
            guard let options = newValue else {
                return
            }
            
            for option in options {
                switch option {
                case let .indicatorViewBackgroundColor(value):
                    indicatorViewBackgroundColor = value
                case let .indicatorViewInset(value):
                    indicatorViewInset = value
                case let .indicatorViewBorderWidth(value):
                    indicatorViewBorderWidth = value
                case let .indicatorViewBorderColor(value):
                    indicatorViewBorderColor = value
                case let .alwaysAnnouncesValue(value):
                    alwaysAnnouncesValue = value
                case let .announcesValueImmediately(value):
                    announcesValueImmediately = value
                case let .panningDisabled(value):
                    panningDisabled = value
                case let .backgroundColor(value):
                    backgroundColor = value
                case let .cornerRadius(value):
                    cornerRadius = value
                case let .bouncesOnChange(value):
                    bouncesOnChange = value
                case let .indicatorBottomViewColor(value):
                    indicatorView.backgroundColor = .clear
                    indicatorView.bottomView.backgroundColor = value
                }
            }
        }
    }
    /// Whether the indicator should bounce when selecting a new index. Defaults to true.
    @IBInspectable public var bouncesOnChange: Bool = true
    
    /// Whether the the control should always send the .ValueChanged event, regardless of the index remaining unchanged after interaction. Defaults to `false`.
    @IBInspectable public var alwaysAnnouncesValue: Bool = false
    
    /// Whether to send the .ValueChanged event immediately or wait for animations to complete. Defaults to `true`.
    @IBInspectable public var announcesValueImmediately: Bool = true
    
    /// Whether the the control should ignore pan gestures. Defaults to `false`.
    @IBInspectable public var panningDisabled: Bool = false
    
    /// The control's and indicator's corner radii.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            indicatorView.cornerRadius = newValue - indicatorViewInset
            segmentViews.forEach { $0.layer.cornerRadius = indicatorView.cornerRadius }
        }
    }
    
    @IBInspectable public var contentViewRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            indicatorView.cornerRadius = newValue - indicatorViewInset
        }
    }
    /// The indicator view's background color.
    @IBInspectable public var indicatorViewBackgroundColor: UIColor? {
        get {
            return indicatorView.backgroundColor
        }
        set {
            indicatorView.backgroundColor = newValue
        }
    }
    /// The indicator view's inset. Defaults to `2.0`.
    @IBInspectable public var indicatorViewInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    /// The indicator view's border width.
    @IBInspectable public var indicatorViewBorderWidth: CGFloat {
        get {
            return indicatorView.layer.borderWidth
        }
        
        set {
            indicatorView.layer.borderWidth = newValue
        }
    }
    /// The indicator view's border color.
    @IBInspectable public var indicatorViewBorderColor: UIColor? {
        get {
            guard let color = indicatorView.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            indicatorView.layer.borderColor = newValue?.cgColor
        }
    }
    
    // MARK: Private properties
    private let normalSegmentsView = UIView()
    private let selectedSegmentsView = UIView()
    private var initialIndicatorViewFrame: CGRect?

    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
 
    private var normalSegmentCount: Int { return normalSegmentsView.subviews.count }
    private var normalSegments: [UIView] { return normalSegmentsView.subviews }
    private var selectedSegments: [UIView] { return selectedSegmentsView.subviews }
    private var segmentViews: [UIView] { return normalSegments + selectedSegments }
    private var totalInsetSize: CGFloat { return indicatorViewInset * 2.0 }
    
    private lazy var defaultSegments: [TSegmentedControlSegment] = {
        return [TLabelSegment(text: "First"), TLabelSegment(text: "Second")]
    }()
    
    private var isLayoutDirectionRightToLeft: Bool {
        let layoutDirection = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
        return layoutDirection == .rightToLeft
    }
    private var lastIndex: Int {
        return segments.endIndex - 1
    }
    
    // MARK: Lifecycle
    /// Initializes a new `TSegmentedControl` with the parameters passed.
    ///
    /// - Parameters:
    ///   - frame: The frame of the control.
    ///   - segments: The segments to configure the control with.
    ///   - index: The initially selected index.
    ///   - options: An array of customization options to style and change the behavior of the control.
    public init(frame: CGRect,
                segments: [TSegmentedControlSegment],
                index: Int = 0,
                options: [TSegmentedControlOption]? = nil,
                selectionStyle: TSIndicatorView.TSIndicatorStyle = .coverBody) {
        self.index = index
        self.segments = segments
        self.indicatorView = TSIndicatorView(style: selectionStyle)
        super.init(frame: frame)
        completeInit()
        self.options = options
    }
    
    /// this method use cover body style automatically
    required public init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.segments = [TLabelSegment(text: "First"), TLabelSegment(text: "Second")]
        self.indicatorView = TSIndicatorView(style: .coverBody)
        super.init(coder: aDecoder)
        completeInit()
    }
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience override public init(frame: CGRect) {
        self.init(frame: frame,
                  segments: [TLabelSegment(text: "First"), TLabelSegment(text: "Second")])
    }
    @available(*, unavailable, message: "Use init(frame:segments:index:options:) instead.")
    convenience init() {
        self.init(frame: .zero,
                  segments: [TLabelSegment(text: "First"), TLabelSegment(text: "Second")])
    }
    private func completeInit() {
        layer.masksToBounds = true
        
        normalSegmentsView.clipsToBounds = true
        addSubview(normalSegmentsView)
        addSubview(indicatorView)
        selectedSegmentsView.clipsToBounds = true
        addSubview(selectedSegmentsView)
        selectedSegmentsView.layer.mask = indicatorView.segmentMaskView.layer
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TSegmentedControl.tapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(TSegmentedControl.panned(_:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        guard segments.count > 1 else { return }
        
        for segment in segments {
            segment.normalView.clipsToBounds = true
            normalSegmentsView.addSubview(segment.normalView)
            segment.selectedView.clipsToBounds = true
            selectedSegmentsView.addSubview(segment.selectedView)
        }
        
        setNeedsLayout()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard normalSegmentCount > 1 else {
            return
        }
        
        normalSegmentsView.frame = bounds
        selectedSegmentsView.frame = bounds
        
        indicatorView.frame = elementFrame(forIndex: index)
        
        for index in 0...normalSegmentCount-1 {
            let frame = elementFrame(forIndex: index)
            normalSegmentsView.subviews[index].frame = frame
            selectedSegmentsView.subviews[index].frame = frame
        }
    }
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultLabelTextSegmentColorsFromInterfaceBuilder()
    }
    
    private func setDefaultLabelTextSegmentColorsFromInterfaceBuilder() {
        guard let normalTLabelSegments = normalSegments as? [UILabel],
            let selectedTLabelSegments = selectedSegments as? [UILabel] else {
                return
        }
        
        normalTLabelSegments.forEach {
            $0.textColor = indicatorView.backgroundColor
        }
        selectedTLabelSegments.forEach {
            $0.textColor = backgroundColor
        }
    }
    
//    @IBInspectable
//    public var unselectedTextColor: UIColor? {
//        didSet {
//            guard let normalTLabelSegments = normalSegments as? [UILabel] else {
//                    return
//            }
//            
//            normalTLabelSegments.forEach {
//                $0.textColor = indicatorView.backgroundColor
//            }
//        }
//    }
    
    
    
    // MARK: Index Setting
    /// Sets the control's index.
    ///
    /// - Parameters:
    ///   - index: The new index.
    ///   - animated: (Optional) Whether the change should be animated or not. Defaults to `true`.
    public func setIndex(_ index: Int, animated: Bool = true) {
        guard normalSegments.indices.contains(index) else { return }
        
        let oldIndex = self.index
        self.index = index
        moveIndicatorViewToIndex(animated, shouldSendEvent: (self.index != oldIndex || alwaysAnnouncesValue))
    }
    
    // MARK: Animations
    private func moveIndicatorViewToIndex(_ animated: Bool, shouldSendEvent: Bool) {
        if animated {
            if shouldSendEvent && announcesValueImmediately {
                sendActions(for: .valueChanged)
            }
            UIView.animate(withDuration: bouncesOnChange ? Animation.withBounceDuration : Animation.withoutBounceDuration,
                           delay: 0.0,
                           usingSpringWithDamping: bouncesOnChange ? Animation.springDamping : 1.0,
                           initialSpringVelocity: 0.0,
                           options: [.beginFromCurrentState, .curveEaseOut],
                           animations: { () -> Void in
                            self.moveIndicatorView()
            }, completion: { finished -> Void in
                if finished && shouldSendEvent && !self.announcesValueImmediately {
                    self.sendActions(for: .valueChanged)
                }
            })
        } else {
            moveIndicatorView()

            if shouldSendEvent {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    // MARK: Helpers
    private func elementFrame(forIndex index: Int) -> CGRect {
        let elementWidth = (width - totalInsetSize) / CGFloat(normalSegmentCount)
        let x = CGFloat(isLayoutDirectionRightToLeft ? lastIndex - index : index) * elementWidth
        return CGRect(x: x + indicatorViewInset,
                      y: indicatorViewInset,
                      width: elementWidth,
                      height: height - totalInsetSize)
    }
    private func nearestIndex(toPoint point: CGPoint) -> Int {
        let distances = normalSegments.map { abs(point.x - $0.center.x) }
        return Int(distances.firstIndex(of: distances.min()!)!)
    }
    private func moveIndicatorView() {
        indicatorView.frame = normalSegments[self.index].frame
        layoutIfNeeded()
    }
    
    // MARK: Action handlers
    @objc private func tapped(_ gestureRecognizer: UITapGestureRecognizer!) {
        let location = gestureRecognizer.location(in: self)
        setIndex(nearestIndex(toPoint: location))
    }
    @objc private func panned(_ gestureRecognizer: UIPanGestureRecognizer!) {
        guard !panningDisabled else { return }
        
        switch gestureRecognizer.state {
        case .began:
            initialIndicatorViewFrame = indicatorView.frame
        case .changed:
            var frame = initialIndicatorViewFrame!
            frame.origin.x += gestureRecognizer.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - indicatorViewInset - frame.width), indicatorViewInset)
            indicatorView.frame = frame
        case .ended, .failed, .cancelled:
            setIndex(nearestIndex(toPoint: indicatorView.center))
        default: break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension TSegmentedControl: UIGestureRecognizerDelegate {
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return indicatorView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

