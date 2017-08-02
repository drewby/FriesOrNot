# Create a Swift iOS app using Microsoft Custom Vision
With Microsoft's Custom Vision Service, it's easy and fast to build, deploy, and improve your own custom image classifier. A custom image classifier can help you identify images of "Bicycles" vs "Cars" or "Steak" vs "Fries". 

After you create your custom image classifier, it's easy to build into any app by using a REST API provided by the Custom Vision service. In addition, you can improve your classifier overtime by using the web interface to upload images, tag images from end users and re-train your model. 

![alt Not fries app image](images/app0.png?raw=true "Not fries app image")![alt Fries app image](images/app1.png?raw=true "Fries app image")

This lab includes the following tasks:

* [Creating a new image classifier project](#creating-a-new-image-classifier-project)
* [Creating your iOS app in Xcode and Swift](#creating-your-ios-app-in-xcode-and-swift)
* [Improving your classifier over time](#improving-your-classifier-over-time)
* [Have more fun with Cognitive Services](#have-more-fun-with-cognitive-services)

### Requirements

The following will be required for you to complete this lab:

* Microsoft Account (MSA) for signing into the Custom Vision service
* At least two sets of images ready to be tagged. Each set should have at least 30 images. (You can use the provided images in the source directory) 
* Additional images for testing your model.
* Software: Xcode
* Optional: iPhone to test your app on a device

### Lab assets

The assets folder of this code repository ([https://github.com/drewby/FriesOrNot](https://github.com/drewby/FriesOrNot)) contains the following:

* Training - a set of images to train your custom image classifier
* Test - some extra images to test your image classifier
* Snippets - a copy of the code used in the lab, in case you don't want to type
* defaultPhoto.png - a place holder image for the Swift app Image View. 

## Creating a new image classifier project

### New Project

1. Open a web browser to http://customvision.ai and sign in using your Microsoft Account (MSA)

    ![alt Sign in to Custom Vision](images/cvs0.png?raw=true "Sign in to Custom Vision")

1. If this is your first time using the service, agree to the Terms of Service by checking the boxes and clicking I agree.

    ![alt Accept agreement](images/cvs2.png?raw=true "Accept agreement")

1. Click **New Project** to create your first project.

    ![alt New project](images/cvs3.png?raw=true "New Project")

1. Enter a name and description for your project. 

1. Select one of the provided Domains, or if you are not sure use General.

    ![alt New project description](images/cvs4.png?raw=true "New Project description")

### Add Images

1. Click **Add images** to add images to your project.

    ![alt Add images](images/cvs5.png?raw=true "Add images")

1. Click **Browse local files** to select images from your local disk. 

    ![alt Open images](images/cvs6.png?raw=true "Open images")

1. Select at least 30 images for your first Tag set. Click **Open**.

    ![alt Open images](images/cvs7.png?raw=true "Open images")

1. Type in a Tag and press the **+** button. You can add additional tags.

    ![alt Add tag](images/cvs8.png?raw=true "Add tag")

1. Now click **Upload ## files**

1. Repeat these steps for at least one more Tag set.

    ![alt Add tag](images/cvs9.png?raw=true "Add tag")

### Train your classifier

1. At the top of the window, find the green button called **Train**. Click it!

    ![alt Train](images/cvs11.png?raw=true "Train")

1. This is all it takes to train your new custom image classifier.

1. Once trained, you will be shown precision and recall indicators which tell you about the performance of your classifier.

    ![alt Train](images/cvs12.png?raw=true "Train")

    > **Precision** - How likely is a tagged image to be correct?
    >
    > **Recall** - How often did your classifier tag correctly?

1. If you are happy with this iteration of your classifier, click the Check mark to make this the default. 

### Test your model

1. At the top of the window, find another button called **Quick Test**

1. Either enter a URL of an image, or **Browse local files** to select an image from your local disk.

1. The Custom Vision service will now use your image classifier model to evaluate this new image and give you a prediction.

### Collect detail for your Prediction API 

1. Click the **Performance** tab again. 

1. At the top of this window, click "Prediction URL".

1. Copy the Prediction URL for uploading an Image.

1. Copy the Prediction Key for accessing the API. 

    ![alt Prediction URL and key](images/cvs13.png?raw=true "Prediction URL and key")

1. Paste these details to a Note for later use.

## Creating your iOS app in Xcode and Swift

### New iOS Project

1. Open Xcode from the /Applications directory.

1. Select **Create a new Xcode project** (or choose **File** > **New** > **Project**)

1. Select iOS at the top of the dialog.

1. In the **Application** section, select **Single View Application** and then click **Next**.
    ![alt Choose a template](images/xcode0.png?raw=true "Choose a template")

1. Use the following values to name your app and choose additional options:
    > **Product Name**: FriesOrNot
    >
    > **Team**: None
    >
    > **Organization Name**: Your name
    >
    > **Organization Identified**: Your org identifier, or com.example.
    >
    > **Language**: Swift
    >
    > **Devices**: Universal
    >
    > **Use Core Data**: Unselected
    >
    > **Include Unit Test**: Selected
    >
    > **Include UI Tests**: Unselected.

    ![alt Choose options for your app project](images/xcode1.png?raw=true "Choose options for your app project")

1. Click **Next**.

1. Select a location to save your project and click **Create**.

1. Click the **Run** button to make sure the empty project works.

    ![alt New project created](images/xcode2.png?raw=true "New project created")

### Add UI objects to Storyboard

1. Open **Main.storyboard** by selecting it from Project Navigator

1. Open the Object library in the utility area (or choose **View** > **Utilities** > **Show Object Library**)

1. In the Object library, filter for "stack view".

1. Drag the **Vertical Stack View** to your scene.

    ![alt Add a stack view to your scene](images/xcode3.png?raw=true "Add a stack view to your scene")

1. Now filter for "label" in Object library.

1. Drag a **Label** and drop it onto the Stack View. 

1. Change the text for the label to "Fries or Not Fries".

1. Drag another **Label** to the Stack View and drop it below the previous one. 

1. Change the text for this label to "Result".

    ![alt Add labels to the stack view](images/xcode4.png?raw=true "Add labels to the stack view")

1. Now filter for "image view" in Object library.

1. Drag an **Image View** to the Stack View and drop it in between the two labels.

    ![alt Add an Image View to the stack view](images/xcode5.png?raw=true "Add an Image View to the stack view")

1. Now filter for "activity" in Object library.

1. Drag an **Activity Indicator View** to the Stack View and drop just below the image view.

    ![alt Add an Activity Indicator to the stack view](images/xcode5b.png?raw=true "Add an Activity Indicator to the stack view")

### Set UI layout properties

1. Use the storyboard scene, or  click in the Outline view to select the Stack View.

1. In the Attributes inspector, set the Spacing to 8.

    ![alt Set spacing to 8](images/xcode6.png?raw=true "Set spacing to 8")

1. Click the Constraints button at the bottom of the canvas window.

    ![alt Set spacing to 8](images/xcode6a.png?raw=true "Set spacing to 8")

1. Above **Spacing to nearest neighbor**, enter 20 for the Top and 0 for the Left and Right boundaries. 

1. Click **Add 3 Constraints**

    ![alt Add three constraints](images/xcode7.png?raw=true "Add three constraints")

1. Now select the Image View.

1. In the Attributes inspector, set the Height to the same as the Width (~350)

    ![alt Set height of Image View](images/xcode8.png?raw=true "Add three constraints")

1. Click the Constraints button. 

1. Check the box **Aspect Ratio** and click 
**Add 1 Constraint**

1. Open Assets.xcassets by clicking in the Project Navigator.

    ![alt Set height of Image View](images/xcode9a.png?raw=true "Set height of Image View")

1. Click the **+** button to add a **New Image Set**

    ![alt Set Image attribute to default Photo](images/xcode10a.png?raw=true "Set Image attribute to default Photo")

1. Double-click the new image set and rename to "defaultPhoto"

1. Drag the defaultPhoto.png from source files to the 2x slot in the image set.

    ![alt Set height of Image View](images/xcode9.png?raw=true "Set height of Image View")

1. Select the **Image View** in the canvas **Main.storyboard** again.

1. Set the **Image** attribute to defaultPhoto.

    ![alt Set Image attribute to default Photo](images/xcode10.png?raw=true "Set Image attribute to default Photo")

1. Check the **User Interaction Enabled** attribute.

    ![alt Set Image attribute to default Photo](images/xcode10b.png?raw=true "Set Image attribute to default Photo")

1. Now in filter for "tap" in the Object library

1. Drag the tap gesture and drop on top of the Image View

### Connect UI objects to code

1. Click to show the Assistant editor. You should now see the Storyboard and Viewcontroller side-by-side.

1. Hold the Control-key and drag the result label to your ViewController just under the line starting with "class".

    ![alt Connect the Image View to code](images/xcode12.png?raw=true "Connect the Image View to code")
    
1. Type "photoImageView" for the **Name** and click **Connect**.

    ![alt Set connection properties for Image view](images/xcode13.png?raw=true " Set connection properties for Image view")

1. Hold the Control-key and drag the activity indicator to your ViewController just under the previous photoImageView definition.

    ![alt Connect the Results label to code](images/xcode14.png?raw=true "Connect the Image View to code")

1. Type "resultLabel" for the **Name** and click **Connect**.

    ![alt Set connection properties for result label](images/xcode15.png?raw=true "Set connection properties for result label")

1. Hold the Control-key and drag the image view to your ViewController just under the previous resultLabel definition.

1. Type "activityIndicator" for the **Name** and click **Connect**.

    ![alt Set connection properties for activity indicator](images/xcode16.png?raw=true "Set connection properties for activity indicator")

1. Hold the Control-key and drag the Tap Gesture (from top of canvas) to your ViewController just above the closing curly brace.

    ![alt Set Image attribute to default Photo](images/xcode16a.png?raw=true "Set Image attribute to default Photo")
    
1. Change the **Connection** to **Action** and the **Type** to **UITapGestureRecognizer**. **Name** the new action "selectImage"

    ![alt Set connection properties for Tap Gesture](images/xcode17.png?raw=true "Set connection properties for Tap Gesture")

### Write code for Image Picker

1. Click to show Standard Editor

    ![alt Set connection properties for Tap Gesture](images/xcode18a.png?raw=true "Set connection properties for Tap Gesture")

1. Make sure ViewController.swift is open in editor.

1. Change the ViewController class defintion to include two more implementations:

    ```swift
    class ViewController: UIViewController,
                        UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate {
    ```

1. Add the following code to the **selectImage** function:

    ```swift
        let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            
            imagePickerController.delegate = self
            
            present(imagePickerController, animated: true, completion: nil)
    ```

1. Add the following function to ViewController:

    ```swift
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    ```

1. Add the following function to ViewController:

    ```swift
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected an image, but was provided \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    ```

1. Open Info.plist

1. At the bottom of the list, click the **+** button.

1. Find "Privacy - Photo Library Usage"

1. Add a description in the Value column such as "See if photos in your library contain Fries or Not Fies."

1. Click the **Run** button to make sure the project works. Try tapping the Image View to select a photo from the photo library.

### Create an object data model for Custom Vision 

1. In Project Navigator, right-click the folder FriesOrNot and click **New File...**

1. Select **Swift File** and click **Next**.

    ![alt Create swift file](images/xcode18.png?raw=true "Create swift file")

1. Name the file "CustomVisionResult" and click **Create**..

    ![alt Create swift file](images/xcode19.png?raw=true "Create swift file")

1. In this file, create the following class:

    ```swift
    struct CustomVisionPrediction {
        let TagId: String
        let Tag: String
        let Probability: Float
        
        public init(json: [String: Any]) {
            let tagId = json["TagId"] as? String
            let tag = json["Tag"] as? String
            let probability = json["Probability"] as? Float
            
            self.TagId = tagId!
            self.Tag = tag!
            self.Probability = probability!
        }
    }
    ```

1. Now to the same file, add the following class:

    ```swift
    struct CustomVisionResult {
        let Id: String
        let Project: String
        let Iteration: String
        let Created: String
        let Predictions: [CustomVisionPrediction]
        
        public init(json: [String: Any]) throws {
            let id = json["Id"] as? String
            let project = json["Project"] as? String
            let iteration = json["Iteration"] as? String
            let created = json["Created"] as? String

            let predictionsJson = json["Predictions"] as? [[String: Any]]
            
            var predictions = [CustomVisionPrediction]()
            for predictionJson in predictionsJson! {
                do
                {
                    let cvp = CustomVisionPrediction(json: predictionJson)
                    predictions.append(cvp)
                }
            }
            
            self.Id = id!
            self.Project = project!
            self.Iteration = iteration!
            self.Created = created!
            self.Predictions = predictions
        }
    }
    ```

### Create a service to call Custom Vision

1. In Project Navigator, right-click the folder FriesOrNot and click **New File...**

1. Select **Swift File** and click **Next**.

1. Name the file "CustomVisionService" and click **Create**..

1. In this file, create the following class:

    ```swift
    class CustomVisionService {
        var preductionUrl = ""
        var predictionKey = ""
        var contentType = "application/octet-stream"
        
        var defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        func predict(image: Data, completion: @escaping (CustomVisionResult?, Error?) -> Void) {
            
            // Create URL Request
            var urlRequest = URLRequest(url: URL(string: preductionUrl)!)
            urlRequest.addValue(predictionKey, forHTTPHeaderField: "Prediction-Key")
            urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            
            // Cancel existing dataTask if active
            dataTask?.cancel()
            
            // Create new dataTask to upload image
            dataTask = defaultSession.uploadTask(with: urlRequest, from: image) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    completion(nil, error)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let result = try? CustomVisionResult(json: json!) {
                        completion(result, nil)
                    }
                }
            }
            
            // Start the new dataTask
            dataTask?.resume()
        }
    }
    ```

1. To complete this class, you need to provide your Prediction URL and Prediction Key we copied earlier.

1. Copy the Prediction URL and paste in the quotes next to **preductionUrl**.

1. Copy the Prediction Key and paste in the quotes next to **predictionKey**.

### Update ViewController to use CustomVisionService

1. Make sure ViewController.swift is open in the Standard Editor.

1. After the IBOutlet properties, add another property:

    ```swift
    var service = CustomVisionService()
    ```

1. Add the following code to imagePickerController:

    ```swift
    resultLabel.text = "" 
    self.activityIndicator.startAnimating()
        
    let imageData = UIImageJPEGRepresentation(selectedImage, 0.8)!
    service.predict(image: imageData, completion: { (result: CustomVisionResult?, error: Error?) in
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.resultLabel.text = error.localizedDescription
            } else if let result = result {
                let prediction = result.Predictions[0]
                let probabilityLabel = String(format: "%.1f", prediction.Probability * 100)
                self.resultLabel.text = "\(probabilityLabel)% sure this is \(prediction.Tag)"
            }
        }
    })
    ```

1. Click the **Run** button to test your project. Now when you pick an Image, the app should request a prediction from Custom Vision. Once returned, it will display the Tags and confidence for each Tag.

## Improving your classifier over time

1. Open a web browser to http://customvision.ai and sign in using your Microsoft Account (MSA).

1. Click the **Predictions** tab

1. On this tab, you will see images that were submitted for Predictions.

1. If you hover your mouse cursor over an image, you'll see how the confidence for each Tag for that image.

    ![alt Predictions tab](images/cvs14.png?raw=true "Predictions tab")

1. If you would like to further train your algorithm, click the image.

1. Add a Tag and click **Save and close**

    ![alt Predictions tab](images/cvs15.png?raw=true "Predictions tab")

1. Click the green **Train** button to retrain your model using your new inputs.

## Have more fun with Cognitive Services

Now that you know how to create your own customer image classifier and use 
that classifier in an app, you can explore using other Cognitive Services
that are pre-trained or ready for you to finalize at [http://microsoft.com/cognitive](http://microsoft.com/cognitive).

For example, use the Face API to detect attributes such as gender, age and emotion
in photo of someone's face. Or use the Computer Vision API to detect all sorts
of objects present in a photo. 

There is an example of using the Face API to decect age and gender in the assets 
folder if this code repository.

![alt Face API example](images/FaceAPI.png?raw=true "Face API example")

