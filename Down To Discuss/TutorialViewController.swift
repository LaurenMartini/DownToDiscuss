//
//  TutorialViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/21/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //REPLACE WITH CORRECT IMAGES
    var images = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg"]
    var count = 0
    
    var pageViewController: UIPageViewController!
    
    @IBAction func swipeLeft(sender: AnyObject) {
        //print swiped?
    }
    
    @IBAction func swiped(sender: AnyObject) {
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        reset()
    }
    
    func reset() {
        /*Get page view controller*/
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(index: 0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        /*subtract the button height (30)
         - and possibly the height between button and bottom on view (20) */
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 30)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
//    @IBAction func start(sender: AnyObject) {
//        let pageContentViewController = self.viewControllerAtIndex(index: 0)
//        self.pageViewController.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, direction: <#T##UIPageViewControllerNavigationDirection#>, animated: <#T##Bool#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    }
//
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewController).pageIndex!
        if (index <= 0) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewController).pageIndex!
        index += 1
        if (index >= self.images.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if((self.images.count == 0) || (index >= self.images.count)) {
            return nil
        }
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! TutorialContentViewController
        
        pageContentViewController.imageName = self.images[index]
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
