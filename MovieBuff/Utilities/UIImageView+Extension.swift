//
//  ImageLoader.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import UIKit

/**
 Note: Re-using an existing extension I use in my personal projects
 */
// TODO: Implement cache and placeholder image
// Loads an image from the given urlString and sets it to the image view
extension UIImageView {
    func loadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage
                }
                
                if let error = error {
                    // TODO: Handle error properly. Create custom errors and propagate back to the caller (view) so it gets handled explicitly.
                    return
                }
            }
        }
        task.resume()
    }
}
