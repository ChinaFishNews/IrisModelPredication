//
//  ViewController.swift
//  IrisModelPredication
//
//  Created by 新闻 on 2017/10/27.
//  Copyright © 2017年 Lvmama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultImageView: UIImageView!
    
    let sepalLength = ["4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let sepalWidth = ["1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let petalLength = ["1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let petalWidth = ["0.25", "0.5", "1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
    }

    // 展示预测结果
    func triggerPrediction () {
        let rowString1 = sepalLength[pickerView.selectedRow(inComponent: 0)]
        let rowString2 = sepalWidth[pickerView.selectedRow(inComponent: 1)]
        let rowString3 = petalLength[pickerView.selectedRow(inComponent: 2)]
        let rowString4 = petalWidth[pickerView.selectedRow(inComponent: 3)]
        
        if let value1 = NumberFormatter().number(from: rowString1)?.doubleValue,
            let value2 = NumberFormatter().number(from: rowString2)?.doubleValue,
            let value3 = NumberFormatter().number(from: rowString3)?.doubleValue,
            let value4 = NumberFormatter().number(from: rowString4)?.doubleValue {
            
            let model = iris()
            let input = irisInput.init(sepal_length__cm_: value1, sepal_width__cm_: value2, petal_length__cm_: value3, petal_width__cm_: value4)
            
            if let predication:irisOutput = try? model.prediction(input: input) {
                var name = "not a iris flower"
                var imageName = ""
                if predication.iris_class == 0 {
                    name = "Setosa"
                    imageName = "iris-setosa"
                } else if predication.iris_class == 1 {
                    name = "Versicolor"
                    imageName = "iris-versicolor"
                } else if predication.iris_class == 2 {
                    name = "Virhinica"
                    imageName = "iris-virginica"
                }
                print("----\(predication.iris_class)")
                self.resultLabel.text = name
                self.resultImageView.image = UIImage.init(named: imageName)
            }
            
        }
    }
}


extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 展示预测结果
        triggerPrediction()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var selectedComponent = sepalLength
        if component == 1 {
            selectedComponent = sepalWidth
        } else if component == 2 {
            selectedComponent = petalLength
        } else if component == 3 {
            selectedComponent = petalWidth
        }
        
        return "\(selectedComponent[row])"
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count: Int = 0
        if component == 0 {
            count = sepalLength.count
        } else if component == 1 {
            count = sepalWidth.count
        } else if component == 2 {
            count = petalLength.count
        } else if component == 3 {
            count = petalWidth.count
        }
        return count
    }
}
