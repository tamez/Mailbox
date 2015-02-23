//
//  MailboxViewController.swift
//  a3Mailbox
//
//  Created by dt on 2/19/15.
//  Copyright (c) 2015 D3. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    // Start Variables
    var messageViewStart: CGPoint!
    var messageImageStart: CGPoint!
    var laterIconStart: CGPoint!
    var listIconStart: CGPoint!
    var archiveIconStart: CGPoint!
    var deleteIconStart: CGPoint!
    var feedImageStart: CGPoint!
    
    // Main Variables
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImage: UIImageView!
    
    // Icon Variables
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!

    // Feed & Overlay Variables
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedTwo: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!

    
    // Load it up!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1240)
       
        // Set Image Positioning
        laterIconStart = laterIcon.center
        listIconStart = laterIcon.center
        archiveIconStart = archiveIcon.center
        deleteIconStart = deleteIcon.center
        feedImageStart = feedImage.center
        
        // Set Icons Alpha
        laterIcon.alpha = 0.0
        listIcon.alpha = 0.0
        archiveIcon.alpha = 0.0
        deleteIcon.alpha = 0.0
        
        // Set Image Alpha
        listImage.alpha = 0.0
        rescheduleImage.alpha = 0.0
        feedTwo.alpha = 0.0
        
        // Extra Snippet
//      listIcon.image = UIImage(named: "laterIcon")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Main Pan Gesture
    
    @IBAction func messagePanPan(sender: UIPanGestureRecognizer) {
        
        // Add Senders
        var translation = sender.translationInView(view)
        var location = sender.translationInView(view)
        var velocity = sender.translationInView(view)
        
    // Gesture States: Pan Left
        
        // Began
        if (sender.state == UIGestureRecognizerState.Began){

            messageImageStart = messageImage.center
            listIcon.alpha = 0.0
            UIView.animateWithDuration(0.5, animations: { () -> Void in
            })
            
        // Changed
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            messageImage.center = CGPoint(x: messageImageStart.x + translation.x, y: messageImage.center.y)
            if (translation.x > -60 && translation.x < 0){
                messageView.backgroundColor = UIColor.grayColor()
                self.laterIcon.alpha = -translation.x / 60
                // That's a nice fade-in fade-out from James D.A.
                
            } else if (translation.x <= -60 && translation.x >= -220) {
                messageView.backgroundColor = UIColorFromRGB(0xF7CA18) // Yellow
                laterIcon.alpha = 1.0
                listIcon.alpha = 0.0
                //  Move the icon
                laterIcon.center.x = laterIconStart.x + location.x + 60
                
            } else if (translation.x < -220) {
                messageView.backgroundColor = UIColorFromRGB(0x463510) // Brown
                laterIcon.alpha = 0.0
                listIcon.alpha = 1.0
                listIcon.center.x = listIconStart.x + location.x + 60
            }

        // Ended
        } else if (sender.state == UIGestureRecognizerState.Ended){
            if (translation.x > -60 && translation.x < 0){
                messageImage.center = messageImageStart
                
            } else if (translation.x <= -60 && translation.x >= -220) {
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.messageImage.center.x = -160
                    self.rescheduleImage.alpha = 1.0
                    self.laterIcon.alpha = 0.0
                    self.listIcon.alpha = 0.0
                })
            } else if (translation.x < -220){
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.messageImage.center.x = -160
                    self.listImage.alpha = 1.0
                    self.laterIcon.alpha = 0.0
                    self.listIcon.alpha = 0.0
                })
            }
        }
        
        
    // Gesture states: Pan Right
        
        // Began
        if (sender.state == UIGestureRecognizerState.Began){
            UIView.animateWithDuration(0.5, animations: { () -> Void in
            })
            
        //Changed
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            if (translation.x > 0 && translation.x < 60){
            messageView.backgroundColor = UIColor.grayColor()
            self.archiveIcon.alpha = translation.x / 60
                
            } else if (translation.x >= 60 && translation.x <= 220){
            messageView.backgroundColor = UIColorFromRGB(0x7BD389) // Green
                archiveIcon.center.x = archiveIconStart.x + location.x - 60
                archiveIcon.alpha = 1.0
                deleteIcon.alpha = 0.0
                
            } else if (translation.x > 220) {
                messageView.backgroundColor = UIColorFromRGB(0xE3655B) // Red
                archiveIcon.alpha = 0.0
                deleteIcon.alpha = 1.0
                deleteIcon.center.x = archiveIconStart.x + location.x - 60
            }
            
        //Ended
        } else if (sender.state == UIGestureRecognizerState.Ended){
            if (translation.x < 60 && translation.x > 0){
                messageImage.center = messageImageStart
            } else if (translation.x >= 60 && translation.x <= 220) {
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.messageImage.center.x = 480
                    self.archiveIcon.alpha = 0.0
                })

            } else if (translation.x > 220){
                messageImage.center.x = 480
            }
        }
    }
    
    // Tap Reschedule Image

    @IBAction func tapRescheduleImage(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rescheduleImage.alpha = 0.0
            self.messageImage.center.x = self.messageImageStart.x
            }) { (Bool) -> Void in
            //
        }
    }

    // Tap List Image
    
    @IBAction func tapListImage(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listImage.alpha = 0.0
            self.feedTwo.alpha = 1.0
            self.messageImage.center.x = self.messageImageStart.x
        })
        }
    
    // Color Hack
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Under The Hood
    //        println("location: \(location)")
    //        println("translation: \(translation.x)")
    //        println("laterIcon location: \(laterIcon.center.x)")
    //        println("listIcon location: \(listIcon.center.x)")


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
