//
//  CoinImageVM.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/29/25.
//

import SwiftUI


@Observable class CoinImageVM{
    var image : UIImage? = nil
    
    init(url : String , coinName: String) {
     
        
        if let imageData = fileExist(directoryName: "Images", fileName: coinName){
            image = imageData
        }
        else{
            Task{
                do {
                    if let directory = createDirectory(directoryName: "Images"),
                       let imageData =  try await getImage(url: url),
                       let response =  createFile(directory: directory,fileName: coinName, image: imageData){
                                await MainActor.run {
                                    image = response
                                }
                    }
                }
                catch{
                    print(error)
                }
            }
        }
    }
    
    
    private func getImage(url: String) async throws -> UIImage?{
        if let url = URL(string: url) {
            let data = try await NetworkManager.request(url: url)
            return  UIImage(data: data)
        }
        return nil
    }
    
    func fileExist(directoryName:String, fileName:String)-> UIImage?{
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{return nil }
        let createdDirectory = cachesDirectory.appending(path: directoryName)
        let fileToCheck = createdDirectory.appending(path:"\(fileName).png")
        if FileManager.default.fileExists(atPath: fileToCheck.path(percentEncoded: false)){
            //print("File created already!")
            return UIImage(contentsOfFile: fileToCheck.path(percentEncoded: false))
        }
        return nil
    }
    
    func createDirectory(directoryName: String)-> URL?{
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{return nil}
        let createdDirectory = cachesDirectory.appending(path: directoryName)
        var isDirectory : ObjCBool = true
        if !FileManager.default.fileExists(atPath: createdDirectory.path(percentEncoded: false), isDirectory: &isDirectory){
            do {
                try FileManager.default.createDirectory(at: createdDirectory, withIntermediateDirectories: false)
               // print("Directory Created")
                return createdDirectory
            }
            catch{
                print(error)
               // print("create directory failed")
                return nil
            }
        }
       // print("Directory Already Created")
        return createdDirectory
    }
    
    
    func createFile(directory: URL, fileName:String ,  image: UIImage) -> UIImage?{
        let newFile = directory.appending(path: "\(fileName).png")
            if let imageData = image.pngData(){
                do{
                    try imageData.write(to: newFile)
                   // print("File Created")
                    return UIImage(contentsOfFile: newFile.path(percentEncoded: false))
                }
                catch{
                    print(error)
                  //  print("image write to directory failed")
                    return nil
                }
            }
        return nil
    }
    
    
}
