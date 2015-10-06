//
//  MailboxViewController.swift
//  cp-3-Mailbox
//
//  Created by Sebastian Drew on 10/1/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var singleMessageView: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sendContentButton: UIButton!
    @IBOutlet weak var returnContentButton: UIButton!

    @IBOutlet weak var singleMessage: UIImageView!
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var segmentedControlMenu: UISegmentedControl!

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var laterScrollView: UIScrollView!
    @IBOutlet weak var archivedScrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var singleMessageInitialCenter: CGPoint!
    var contentViewInitialCenter: CGPoint!
    
    var contentViewInitialX: CGFloat!
    
    // var startDragOrigin: CGPoint!
    // var laterIconOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singleMessageInitialCenter = singleMessageView.center
        contentViewInitialCenter = contentView.center
        contentViewInitialX = contentView.frame.origin.y
        
        rescheduleView.alpha = 0
        listView.alpha = 0
        sendContentButton.enabled = true
        sendContentButton.hidden = false

        scrollView.contentSize = CGSize(width: 320, height: 1368)
        laterScrollView.contentSize = feedImage.image!.size
        archivedScrollView.contentSize = feedImage.image!.size
        menuScrollView.contentSize = menuImage.image!.size
        returnContentButton.hidden = true
        
        laterScrollView.alpha = 0
        archivedScrollView.alpha = 0
        
        laterIcon.alpha = 0
        listIcon.alpha = 0
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        
        activityIndicator.alpha = 0
        
        scrollView.delegate = self
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        
        edgeGesture.edges = UIRectEdge.Left
        
       contentView.addGestureRecognizer(edgeGesture)
        
        let parentEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "parentEdgeGesture:")
        
        parentEdgeGesture.edges = UIRectEdge.Right
        
        parentView.addGestureRecognizer(parentEdgeGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: Scrollview Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
       // print("content offset \(scrollView.contentOffset.y)")

    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
         if feedImage.center.y == 680 {
            UIView.animateWithDuration(0.4) { () -> Void in
            self.activityIndicator.alpha = 1
            }
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            if feedImage.center.y == 680 && scrollView.contentOffset.y < -50 {
                
                
                activityIndicator.startAnimating()
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.mainScrollView.center.y = 370
                })
                delay(2, closure: { () -> () in
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.feedImage.center.y = 766
                        self.mainScrollView.center.y = 316
                    })
                    self.singleMessage.center.x = 160
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                })
                
            }

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        
    }
    
    
   // MARK: Button Actions
    
    @IBAction func sendContentView(sender: AnyObject) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.parentView.center.x = 430
            self.sendContentButton.hidden = true
            self.returnContentButton.hidden = false
            self.contentView.userInteractionEnabled = false
        }
    }
    
    @IBAction func returnContentView(sender: AnyObject) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.parentView.center.x = 160
            self.returnContentButton.hidden = true
            self.contentView.userInteractionEnabled = true
        }
    }
    
    
    
    // MARK: Message Pan Gesture
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        // let location = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
           // NSLog("began panning to")
            singleMessageInitialCenter = singleMessage.center
           // laterIconOrigin = laterIcon.frame.origin
            // startDragOrigin = location
            
            

        } else if sender.state == UIGestureRecognizerState.Changed {
            
            //  NSLog("currently panned to")
            singleMessage.center = (CGPoint(x: singleMessageInitialCenter.x + translation.x, y: singleMessageInitialCenter.y))
            
            
            if singleMessage.center.x < 100 && singleMessage.center.x > -60 {
                
                // message container background - yellow - archive
                
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:1, green:0.827, blue:0.125, alpha:1)
                  //  self.laterIcon.frame.origin.x = self.laterIconOrigin.x + location.x - self.startDragOrigin.x - 60
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                    
                }
            } else if singleMessage.center.x < -60 {
                
                // message container background - orange - list
                
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.847, green:0.651, blue:0.459, alpha:1)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                }

            } else if singleMessage.center.x > 260 && singleMessage.center.x < 380 {
                
                // message container background - green - save
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.384, green:0.851, blue:0.384, alpha:1)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                })
            } else if singleMessage.center.x > 380 {
                
                // message container background - red - delete
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.937, green:0.329, blue:0.047, alpha:1)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 1
                })
            } else if singleMessage.center.x < 260 && singleMessage.center.x > 60 {
                
                // message container background - gray - none
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.827, green:0.839, blue:0.859, alpha:1)
                })
                    laterIcon.alpha = translation.x / (60 * -1)
                    archiveIcon.alpha = translation.x / (60 * 1)
                    listIcon.alpha = 0
                    deleteIcon.alpha = 0
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if singleMessage.center.x < 100 && singleMessage.center.x > -60 {
                
                // Send message away on swipe left and load archive options modal
                
                UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = -160
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.4, animations: { () -> Void in
                            self.rescheduleView.alpha = 1
                            self.parentView.userInteractionEnabled = false
                        })
                })
               
            } else if singleMessage.center.x < -60 {
                
                // Send message away on swipe left and load list options modal
                
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = -160
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.4, animations: { () -> Void in
                            self.listView.alpha = 1
                            self.parentView.userInteractionEnabled = false
                        })
                })
                
            } else if singleMessage.center.x > 260  {
                
                // Send message away and remove on swipe right (both delete and archive)
                
                UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = 480
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2 , animations: { () -> Void in
                            self.singleMessageView.backgroundColor = UIColor(red:0.827, green:0.839, blue:0.859, alpha:1)
                            }, completion: { (Bool) -> Void in
                                UIView.animateWithDuration(0.2, animations: { () -> Void in
                                    self.feedImage.center.y = 680

                                })
                        })
                })
                
            } else if singleMessageView.center.x < 260 && singleMessage.center.x > 60 {
                
                // Return to initial location (user did not commit)
                
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = 160
                    }, completion: nil)
            }
        }

    }
    
    // MARK: Tap Gestures
    
    
    @IBAction func rescheduleDidTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = 160
                    }, completion: nil)
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.827, green:0.839, blue:0.859, alpha:1)
                })
        }
        self.parentView.userInteractionEnabled = true
    }
    
    @IBAction func listDidTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.listView.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.singleMessage.center.x = 160
                    }, completion: nil)
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.singleMessageView.backgroundColor = UIColor(red:0.827, green:0.839, blue:0.859, alpha:1)
                })
        }
        self.parentView.userInteractionEnabled = true

    }
    
    // MARK: Edge Gestures
    
    // Open main menu
    
    @IBAction func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
       
            contentViewInitialCenter = parentView.center
        
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            parentView.center = (CGPoint(x: contentViewInitialCenter.x + translation.x, y: contentViewInitialCenter.y))
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
          if parentView.center.x > 220 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.parentView.center.x = 430
                })
                contentView.userInteractionEnabled = false
                sendContentButton.hidden = true
                returnContentButton.hidden = false
            
            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.parentView.center.x = 160
                })

            }

        }
    }
    
    // Close main menu
    
    @IBAction func parentEdgeGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            contentViewInitialCenter = parentView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            parentView.center = CGPoint(x: contentViewInitialCenter.x + translation.x, y: contentViewInitialCenter.y)
           
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.parentView.center.x = 160
            })
            contentView.userInteractionEnabled = true
            sendContentButton.hidden = false
            returnContentButton.hidden = true
        }
    }
    
    // MARK: Segmented control options
    
    @IBAction func segmentedControl(sender: AnyObject) {
        
        let selectedItem = self.segmentedControlMenu.selectedSegmentIndex
        
        // Archive - yellowColor
        
        if selectedItem == 0 {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.segmentedControlMenu.tintColor = UIColor(red:1, green:0.827, blue:0.125, alpha:1)
                self.mainScrollView.center.x = 480
                self.laterScrollView.center.x = 160
                self.archivedScrollView.center.x = 800
                self.archivedScrollView.alpha = 0
                self.mainScrollView.alpha = 0
                self.laterScrollView.alpha = 1
            })
        }
        
        // Main - lightBlueColor
        
        if selectedItem == 1 {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.segmentedControlMenu.tintColor = UIColor(red:0.267, green:0.667, blue:0.824, alpha:1)
                self.mainScrollView.center.x = 160
                self.laterScrollView.center.x = -160
                self.archivedScrollView.center.x = 480
                self.archivedScrollView.alpha = 0
                self.laterScrollView.alpha = 0
                self.mainScrollView.alpha = 1
            })
        }
        
        // Later - greenColor
        
        if selectedItem == 2 {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.segmentedControlMenu.tintColor = UIColor(red:0.384, green:0.851, blue:0.384, alpha:1)
                self.mainScrollView.center.x = -160
                self.archivedScrollView.center.x = 160
                self.laterScrollView.center.x = -480
                self.mainScrollView.alpha = 0
                self.archivedScrollView.alpha = 1
                self.laterScrollView.alpha = 0
            })
            
        }
        
    }
    
    
}
