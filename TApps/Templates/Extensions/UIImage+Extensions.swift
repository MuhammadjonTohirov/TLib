//
//  UIImage+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 09/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit
import Photos
import Kingfisher

extension UIImage {
    func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom),
            false,
            self.scale)
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
    
    func resizeImage(_ newSize: CGSize) -> UIImage? {
        func isSameSize(_ newSize: CGSize) -> Bool {
            return size == newSize
        }

        func scaleImage(_ newSize: CGSize) -> UIImage? {
            func getScaledRect(_ newSize: CGSize) -> CGRect {
                let ratio   = max(newSize.width / size.width, newSize.height / size.height)
                let width   = size.width * ratio
                let height  = size.height * ratio
                return CGRect(x: 0, y: 0, width: width, height: height)
            }

            func _scaleImage(_ scaledRect: CGRect) -> UIImage? {
                UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
                draw(in: scaledRect)
                let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                return image
            }
            return _scaleImage(getScaledRect(newSize))
        }

        return isSameSize(newSize) ? self : scaleImage(newSize)!
    }

    open func changeColor (_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context!.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    public static func getImage(asset: PHAsset, completion: @escaping ((UIImage?) -> Void)) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 300.0, height: 300.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            completion(result)
        })
    }
    
    public static func setImage(asset: PHAsset?, view: UIImageView) {
        if let asset = asset {
            self.getImage(asset: asset) { (image) in
                DispatchQueue.main.async {
                    view.image = image
                }
            }
        }
    }
}

extension UIImageView {
    public func download(urlString: String, placeholder: UIImage? = nil, withCache: Bool = true, compression: CGFloat = 0.5) {
        let encodedURL = urlString.encodeUrl
        self.image = placeholder
        let url = URL(string: encodedURL)
        
        let key = "\(encodedURL)"
        
        self.download(url: url, placeholder: placeholder, withCache: withCache, key: key, compression: compression)
    }
    
    private func download(url _uu: URL?, placeholder: UIImage? = nil, withCache: Bool = true, key kk: String, compression: CGFloat = 0.5) {
        var key = kk
        
        if key.count > 100 {
            key = (_uu?.absoluteString.split("/").last ?? "_no_key_error_image").substringToIndex(10)
        }
        
        let url = URL(string: _uu?.absoluteString ?? "")
        var options: [KingfisherOptionsInfoItem] = withCache ? [.memoryCacheExpiration(.days(2)), .diskCacheExpiration(.days(5)), .cacheOriginalImage, .targetCache(ImageCache(name: key.placeholder("12__123")))] : []
        
        options.append(.scaleFactor(UIScreen.main.scale))
        options.append(.transition(.fade(0.1)))
        self.kf.indicatorType = .activity
        
        self.kf.setImage(with: url, placeholder: placeholder, options: options)
    }
    
    @available(*, deprecated, message: "This method has been deprecated")
    private func download(url: URL?, withCache: Bool = true, key: String, compression: CGFloat = 0.5, completion: ((Bool) -> ())? = nil) {
        let cache = ImageCache.default
        
        if let url = url {
            
            func ifNotCashed() {
                self.kf.setImage(with: url) { result in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            guard let data = value.image.jpegData(compressionQuality: 0.5), let image = UIImage(data: data)  else {
                                    completion?(false)
                                return
                            }
    
                            completion?(true)
                        
                            
                            if cache.imageCachedType(forKey: key).cached {
                                return
                            }

                            if withCache {
                                cache.store(image, forKey: key)
                            }
                        }
                        
                    default:
                        DispatchQueue.main.async {
                            completion?(false)
                        }
                    }
                }
            }
            func retrieve() {
                cache.retrieveImage(forKey: key) { (result) in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            guard let data = value.image?.jpegData(compressionQuality: compression), let image = UIImage(data: data)  else {
                                ifNotCashed()
                                return
                            }
                            self.image = image
                            completion?(true)
                        }
                    case .failure:
                        ifNotCashed()
                        break
                    }
                }
            }
            
            
            DispatchQueue.main.async {
                retrieve()
            }

        } else {
            DispatchQueue.main.async {
                completion?(false)
            }
        }
    }
    
    public func saveImage(_ name: String) {
        let fileManager = FileManager.default
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? "no app directory"
        let directory = "\(path)/qrImages/"
        
        if !fileManager.fileExists(atPath: directory) {
            fileManager.createFile(atPath: directory, contents: nil, attributes: nil)
        }
        
        let filePath = "\(directory)\(name).png"
        
        if !fileManager.fileExists(atPath: filePath) {
            do {
                if let data = self.asImage().pngData() {
                    try data.write(to: URL(fileURLWithPath: filePath))
                }
            } catch let error {
                print(error)
            }
        }
    }

    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    func wrapWidth() {
        guard let image = image else { return }
        guard contentMode == .scaleAspectFit else { return }
        guard image.size.width > 0 && image.size.height > 0 else { return }
        
        let scale = image.size.width / image.size.height
        self.width = scale * self.height
    }
}
