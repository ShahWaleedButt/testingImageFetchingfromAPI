//
//  ViewController.swift
//  imagefetch
//
//  Created by ShahWaleed  on 2022-11-05.
//

import UIKit

class ViewController: UIViewController {
    var imagefromlink: UIImage?
    
    @IBAction func reloadImage(_ sender: UIButton) {
        fetchdata(url: urltofetch)
    }
    
    @IBOutlet weak var imageData: UIImageView!
    
    let urltofetch: String = "https://dog.ceo/api/breeds/image/random"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
  
        
    }
    
    func fetchdata(url: String){
        if let correcturl = URL(string: url){
            let browser = URLSession(configuration: .default)
            let search = browser.dataTask(with: correcturl) { data, response, error in
                if let errorvalue = error {
                    print(errorvalue.localizedDescription)
                    
                }
                if let unwrappeddata = data {
                    print(unwrappeddata)
                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(AllData.self, from: unwrappeddata)
                        print(decoded.status)
                        print(decoded.message)
                        
                        let newimglink = decoded.message
                        
                        let poster = try Data(contentsOf: URL(string: newimglink)!)
                        DispatchQueue.main.async {
                            self.imageData.image = UIImage(data: poster)
                            
                        }
                        
                    }
                    catch{
                        
                        print("couldnt decode")
                        print(error.localizedDescription)
                    }
                }
            }
            
            .resume()  }
        else {print("incorrect url")}
            
    }
        

}

