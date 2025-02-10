//
// File name: PhotoLibraryManager.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import PhotosUI

@MainActor
final class PhotoLibraryManager: ObservableObject {
    static let shared = PhotoLibraryManager()
    
    @Published var selectedImage: UIImage?
    
    private init() {}
    
    func saveImageTolibrary(_ image: UIImage, completion: @escaping (_ isSuccess: Bool) -> Void) {
        checkAuthorizationStatus { isSuccess in
            guard isSuccess else {
                completion(false)
                return
            }
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { isSuccessLoad, error in
                DispatchQueue.main.async {
                    completion(isSuccess && error == nil)
                }
            }
        }
    }
    
    func checkAuthorizationStatus(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    completion(status == .authorized || status == .limited)
                }
            }
        case .restricted, .denied:
            completion(false)
        case .authorized, .limited:
            completion(true)
        @unknown default:
            fatalError("Unknown authorization status for PHPhoto Library")
        }
    }
}
