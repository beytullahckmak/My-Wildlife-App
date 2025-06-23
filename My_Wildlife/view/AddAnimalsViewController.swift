import FirebaseFirestore
import FirebaseStorage

class AddAnimalsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var imageAnimal: UIImageView!
    @IBOutlet weak var kategoriText: UITextField!
    @IBOutlet weak var altKategoriText: UITextField!
    @IBOutlet weak var turText: UITextField!
    @IBOutlet weak var aniText: UITextField!
    @IBOutlet weak var isoText: UITextField!
    @IBOutlet weak var diyaframText: UITextField!
    @IBOutlet weak var enstantaneText: UITextField!
    @IBOutlet weak var animalInfoText: UITextField!

    let kategoriPicker = UIPickerView()
    let altKategoriPicker = UIPickerView()
    let turPicker = UIPickerView()

    var kategoriler: [String] = []
    var altKategoriler: [String] = []
    var turler: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriText.delegate = self
        altKategoriText.delegate = self
        turText.delegate = self

        imageAnimal.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageAnimal.addGestureRecognizer(gestureRecognizer)

        setupPickers()
        fetchKategoriler()
    }

    func setupPickers() {
        kategoriPicker.delegate = self
        kategoriPicker.dataSource = self
        kategoriText.inputView = kategoriPicker
        kategoriText.inputAccessoryView = createToolbar(selector: #selector(kategoriSecildi))

        altKategoriPicker.delegate = self
        altKategoriPicker.dataSource = self
        altKategoriText.inputView = altKategoriPicker
        altKategoriText.inputAccessoryView = createToolbar(selector: #selector(altKategoriSecildi))

        turPicker.delegate = self
        turPicker.dataSource = self
        turText.inputView = turPicker
        turText.inputAccessoryView = createToolbar(selector: #selector(turSecildi))

        kategoriPicker.tag = 0
        altKategoriPicker.tag = 1
        turPicker.tag = 2
    }
    
    func fetchKategoriler() {
        let firestore = Firestore.firestore()
        firestore.collection("categories").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.kategoriler = snapshot.documents.map { $0.documentID }
                self.kategoriPicker.reloadAllComponents()
            }
        }
    }

    func fetchAltKategoriler(for kategori: String) {
        let firestore = Firestore.firestore()
        firestore.collection("categories").document(kategori).collection("subcategories").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.altKategoriler = snapshot.documents.map { $0.documentID }
                self.altKategoriPicker.reloadAllComponents()
            }
        }
    }

    func fetchTurler(for kategori: String, altKategori: String) {
        let firestore = Firestore.firestore()
        firestore.collection("categories").document(kategori).collection("subcategories").document(altKategori).collection("species").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.turler = snapshot.documents.map { $0.documentID }
                self.turPicker.reloadAllComponents()
            }
        }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: return kategoriler.count
        case 1: return altKategoriler.count
        case 2: return turler.count
        default: return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: return kategoriler[row]
        case 1: return altKategoriler[row]
        case 2: return turler[row]
        default: return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            kategoriText.text = kategoriler[row]
            fetchAltKategoriler(for: kategoriler[row])
        case 1:
            altKategoriText.text = altKategoriler[row]
            if let kategori = kategoriText.text {
                fetchTurler(for: kategori, altKategori: altKategoriler[row])
            }
        case 2:
            turText.text = turler[row]
        default: break
        }
    }

    func createToolbar(selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: selector)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([space, doneButton], animated: false)
        return toolbar
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == kategoriText && kategoriler.count == 1 {
            pickerView(kategoriPicker, didSelectRow: 0, inComponent: 0)
        } else if textField == altKategoriText && altKategoriler.count == 1 {
            pickerView(altKategoriPicker, didSelectRow: 0, inComponent: 0)
        } else if textField == turText && turler.count == 1 {
            pickerView(turPicker, didSelectRow: 0, inComponent: 0)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Bu metod kullanıcı klavye ile yazmaya çalıştığında çağrılır
        if textField == kategoriText || textField == altKategoriText {
            return false // kategori ve alt kategoriye yazmayı engelle
        }
        return true // diğer alanlara yazmaya devam etsin
    }

    @objc func kategoriSecildi() {
        kategoriText.resignFirstResponder()
    }

    @objc func altKategoriSecildi() {
        altKategoriText.resignFirstResponder()
    }

    @objc func turSecildi() {
        turText.resignFirstResponder()
    }

    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageAnimal.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func clearForm() {
        self.imageAnimal.image = UIImage(systemName: "photo")
        self.kategoriText.text = ""
        self.altKategoriText.text = ""
        self.turText.text = ""
        self.aniText.text = ""
        self.isoText.text = ""
        self.diyaframText.text = ""
        self.enstantaneText.text = ""
        self.animalInfoText.text = ""
    }

    @IBAction func addButtonOnClick(_ sender: Any) {
        let Storage = Storage.storage()
        let storageRef = Storage.reference()
        let mediaFolder = storageRef.child("media")

        if let data = imageAnimal.image?.jpegData(compressionQuality: 0.5) {
            let imageRef = mediaFolder.child("\(Date().timeIntervalSince1970).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }

                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("url Hatası:\(error.localizedDescription)")
                        return
                    }

                    guard let imageURL = url?.absoluteString else { return }
                    let fireStore = Firestore.firestore()

                    guard let kategori = self.kategoriText.text,
                          let altKategori = self.altKategoriText.text,
                          let tur = self.turText.text,
                          let ani = self.aniText.text,
                          let iso = self.isoText.text,
                          let diyafram = self.diyaframText.text,
                          let enstantane = self.enstantaneText.text,
                          let hayvanHakkında = self.animalInfoText.text else {
                        print("Gerekli alanlar eksik.")
                        return
                    }

                    let ayarlar = cameraSettings(ISO: iso, aperture: diyafram, shutterSpeed: enstantane)
                    let photoData: [String: Any] = [
                        "image_url": imageURL,
                        "description": ani,
                        "cameraSettings": ayarlar.toDictinory(),
                        "animalInfo": hayvanHakkında,
                        "created_at": Timestamp(date: Date())
                    ]

                    let photoRef = fireStore
                        .collection("categories")
                        .document(kategori)
                        .collection("subcategories")
                        .document(altKategori)
                        .collection("species")
                        .document(tur)
                        .collection("photos")
                        .document()

                    photoRef.setData(photoData) { error in
                        if let error = error {
                            print("Firestore ekleme hatası: \(error.localizedDescription)")
                        } else {
                            print("Fotoğraf başarıyla Firestore'a eklendi.")
                            self.clearForm()
                        }
                    }
                }
            }
        }
    }
}
