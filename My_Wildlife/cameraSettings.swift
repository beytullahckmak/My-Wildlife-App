import Foundation

class cameraSettings{
    var ISO : String
    var aperture : String
    var shutterSpeed : String
    
    init(ISO: String, aperture: String, shutterSpeed: String) {
        self.ISO = ISO
        self.aperture = aperture
        self.shutterSpeed = shutterSpeed
    }
    func toDictinory() -> [String: Any] {
        return ["ISO": ISO, "aperture": aperture, "shutterSpeed": shutterSpeed]
    }
}
