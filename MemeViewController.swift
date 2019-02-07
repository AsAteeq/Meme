//
//  MemeViewController.swift
//  Meme.0.1
//
//  Created by Osiem Teo on 09/03/1440 AH.
//  Copyright © 1440 Asma. All rights reserved.
//
// protocol + camera unabeled+ viewDidLoad (tp+bottom)
import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var cameraB: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var shareB: UIBarButtonItem!
    let memeTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.strokeColor.rawValue: UIColor.black,
        NSAttributedString.Key.strokeWidth.rawValue: -4.0,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        ] as! [NSAttributedString.Key : Any]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        textFieldFunc(textFiled: topTextField)
        textFieldFunc(textFiled: bottomTextField)
        
         cameraB.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareB.isEnabled = false
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (MemeViewController.dismissKeyborad))
        view.addGestureRecognizer(tap)
    }
    func textFieldFunc (textFiled : UITextField){
        textFiled.defaultTextAttributes = memeTextAttributes
        textFiled.textAlignment = .center
        textFiled.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    @objc func dismissKeyborad(){
        view.endEditing(true)
    }
    
    func pickAnImage(sourceType : UIImagePickerController.SourceType) {
        let pickerImage = UIImagePickerController()
        
        pickerImage.delegate = self
        pickerImage.sourceType = sourceType
        pickerImage.allowsEditing = false
        
        present(pickerImage, animated: true, completion: nil)
        shareB.isEnabled = true 
        
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        pickAnImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType: UIImagePickerController.SourceType.camera)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
    }
    @objc func keyboardWillHide (_ notification:Notification){
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    func subscribeToKeyboardNotifications() {
        
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object : nil)
       
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name : UIResponder.keyboardWillHideNotification, object : nil)
    }
    
    func save(){
        
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage )
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    
    func generateMemedImage() -> UIImage {
        
        
        bottomToolbar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomToolbar.isHidden = false
        return memedImage
    }
    @IBAction func share(_ sende :Any){
        let memeImg = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeImg], applicationActivities: nil)
        activity.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool , returnedItems : [Any]?, error: Error?) in if
            completed{
            self.save()
            }
            
        }
        present(activity, animated: true, completion: nil)
    }
}
