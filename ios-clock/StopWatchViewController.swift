//
//  StopWatchViewController.swift
//  ios-clock
//
//  Created by Carlos andres Diaz bravo  on 2020-06-03.
//

import UIKit

class StopWatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var laps : [String] = []
    var timer  = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var  stopwatchString: String = ""
    var startStopWatch: Bool = true
    var addLap: Bool = false

    var stopwatchLabel: UILabel = {
        let l = UILabel()
        l.text = "00:00:00"
        l.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: 200)
        l.textAlignment = NSTextAlignment.center
        l.textColor = UIColor.white
        l.font = l.font.withSize(60)
        return l
    }()
    
    var timeDisplayView: AnalogStopWatch = {
        let t = AnalogStopWatch()
        t.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 250)
        return t
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startstopButton: UIButton!
    
    @IBOutlet weak var lapresetButton: UIButton!
    
    var pages = [UIViewController]()
    
    @IBAction func startStop(_ sender: Any) {
        if startStopWatch == true {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:  #selector(self.updateStopwatch), userInfo: nil, repeats: true)
            
            startStopWatch = false
            startstopButton.setImage(UIImage(named: "StopButton.png"), for: UIControl.State.normal)
            lapresetButton.setImage(UIImage(named: "LapButton.png"), for: UIControl.State.normal)
            
            addLap = true
        }else {
            
            timer.invalidate()
            startStopWatch = true
            startstopButton.setImage(UIImage(named: "StartButton.png"), for: .normal)
            lapresetButton.setImage(UIImage(named: "ResetButton.png"), for: .normal)
            
            addLap = false
            
        }
        
    }
    
    
    @IBAction func lapReset(_ sender: Any) {
        
        if addLap == true  {
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()
            
        }else {
            addLap = false
            lapresetButton.setImage(UIImage(named: "LapButton.png"), for: .normal)
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            stopwatchString = "00:00:00"
            stopwatchLabel.text = stopwatchString
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionView")

        let page1 = UIViewController()
        page1.view.addSubview(stopwatchLabel)
        page1.view.backgroundColor = UIColor.black
        self.pages.append(page1)

        let page2 = UIViewController()
        page2.view.backgroundColor = UIColor.black
        page2.view.addSubview(timeDisplayView)
        self.pages.append(page2)
    }
    
   @objc func updateStopwatch(){
        
        fractions += 1
        if fractions == 100 {
             seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopwatchLabel.text = stopwatchString
    
        timeDisplayView.updateDisplay(minutes: minutes, seconds: seconds)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell (style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
        
    }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
         
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }
         
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView", for: indexPath)
            cell.contentView.addSubview(pages[indexPath.row].view)
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = self.collectionView.frame.size.width
            let height = self.collectionView.frame.size.height
            return CGSize(width: width, height: height)
        }

}
