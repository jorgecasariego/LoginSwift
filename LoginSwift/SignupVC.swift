//
//  SignupVC.swift
//  LoginSwift
//
//  Created by Jorge Casariego on 29/10/14.
//  Copyright (c) 2014 Jorge Casariego. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        var username:NSString = usernameTextField.text as NSString
        var password:NSString = passwordTextField.text as NSString
        var confirmPass:NSString = confirmPasswordTextField.text as NSString
        
        if(username.isEqualToString("") || password.isEqualToString("")){
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Fallo al registrarse!"
            alertView.message = "Favor ingresar usuario y contraseña"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if(!password.isEqual(confirmPass)){
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Fallo al registrarse!"
            alertView.message = "Las constraseñas no coinciden"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()

        } else{
            var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirmPass)"
            NSLog("Post Data: %@", post)
            
            var url:NSURL = NSURL(string: "http://dipinkrishna.com/jsonsignup.php")!
            var postdata:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            var postLenght:NSString = String(postdata.length)
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postdata
            request.setValue(postLenght, forHTTPHeaderField: "Content-Lenght")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var responseError: NSError?
            var response: NSURLResponse?
            
            var urlData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &responseError)
            
            if(urlData != nil){
                let res = response as NSHTTPURLResponse!
                
                NSLog("Response code: %ld", res.statusCode)
                
                if(res.statusCode >= 200 && res.statusCode < 300){
                    var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData)
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("success") as NSInteger
                    
                    //[jsonData[@"success"] integerValue]
                    
                    NSLog("Success: %ld", success)
                    
                    if(success == 1){
                        NSLog("Sign Up Success")
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else{
                        var error_msg:NSString
                        
                        if(jsonData["error_message"] as? NSString != nil){
                            error_msg = jsonData["error_message"] as NSString
                        } else{
                            error_msg = "Unknown Error"
                        }
                        
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Registro fallido"
                        alertView.message = error_msg
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else{
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Registro fallido"
                    alertView.message = "Conexion Fallida"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Fallo al Iniciar sesión"
                alertView.message = "Error de conexion"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
            
        }
    }

    @IBAction func gotoLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
