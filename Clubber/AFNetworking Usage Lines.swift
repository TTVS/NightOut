

    // SwiftyJSON nicely wraps the result of the Alamofire JSON response handler:
//Alamofire.request(.GET, url, parameters: parameters)
//    .responseJSON { (req, res, json, error) in
//        if(error != nil) {
//            NSLog("Error: \(error)")
//            println(req)
//            println(res)
//        }
//        else {
//            NSLog("Success: \(url)")
//            var json = JSON(json!)
//        }
//}





// COPY OF REQUEST (GET)
//func makeSignInRequest() {
//    let manager = AFHTTPRequestOperationManager()
//    let url = "https://nightout.herokuapp.com/api/v1/"
//    let parameter = nil
//    
//    manager.requestSerializer = AFJSONRequestSerializer()
//    
//    manager.GET(url,
//        parameters: nil,
//        success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
//            print("JSON: " + responseObject.description)
//            
//            let paperNavController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("RootPaperNavigationVC")
//            self.presentViewController(paperNavController, animated: true, completion: nil)
//            
//            let successMenu = UIAlertController(title: nil, message: "Successfully get from server", preferredStyle: UIAlertControllerStyle.Alert)
//            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {
//                (alert: UIAlertAction) -> Void in
//                print("Success")
//            })
//            successMenu.addAction(okAction)
//            
//            self.presentViewController(successMenu, animated: true, completion: nil)
//            
//        },
//        failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//            print("Error: " + error.localizedDescription)
//            
//            
//            let errorMenu = UIAlertController(title: nil, message: "Failed to get from server.", preferredStyle: UIAlertControllerStyle.Alert)
//            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {
//                (alert: UIAlertAction) -> Void in
//                print("Cancelled")
//            })
//            errorMenu.addAction(okAction)
//            
//            self.presentViewController(errorMenu, animated: true, completion: nil)
//    })
//
//
//
// COPY OF RESPONSE (POST)
//func makeSignUpRequest() {
//    let manager = AFHTTPRequestOperationManager()
//    let url = "https://nightout.herokuapp.com/api/v1/users?"
//    let signUpParams = [
//        "user[email]" : "\(emailTextField.text!)",
//        "user[password]" : "\(passwordTextField.text!)",
//        "user[password_confirmation]" : "\(passwordConfirmationTextField.text!)",
//        "user[first_name]" : "\(firstNameTextField.text!)",
//        "user[last_name]" : "\(lastNameTextField.text!)",
//        "user[type]" : "Guest"
//    ]
//    
//    print("\(emailTextField.text)")
//    print("\(passwordTextField.text)")
//    print("\(passwordConfirmationTextField.text)")
//    print("\(firstNameTextField.text)")
//    print("\(lastNameTextField.text)")
//    
//    manager.responseSerializer = AFJSONResponseSerializer()
//    
//    manager.POST(url,
//        parameters: signUpParams,
//        success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
//            print("Yes this was a success.. \(responseObject.description)")
//            
//            self.displayAlertMessage("Success", alertDescription: "Account has been created")
//            
//            let paperNavController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("signInVC")
//            self.presentViewController(paperNavController, animated: true, completion: nil)
//            
//        },
//        failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
//            print("We got an error here.. \(error.localizedDescription)")
//    })
//}
//

















//
//
//
//
//[self GET:@"weather.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//    if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
//        [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
//    }
//} failure:^(NSURLSessionDataTask *task, NSError *error) {
//    if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//        [self.delegate weatherHTTPClient:self didFailWithError:error];
//    }
//}];
//
/////////////////////////////
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == [actionSheet cancelButtonIndex]) {
//        // User pressed cancel -- abort
//        return;
//    }
//    
//    // 1
//    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
//    NSDictionary *parameters = @{@"format": @"json"};
//    
//    // 2
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    // 3
//if (buttonIndex == 0) {
//    [manager GET:@"weather.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        self.weather = responseObject;
//        self.title = @"HTTP GET";
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//        message:[error localizedDescription]
//        delegate:nil
//        cancelButtonTitle:@"Ok"
//        otherButtonTitles:nil];
//        [alertView show];
//    }];
//}
//
//
//
//
