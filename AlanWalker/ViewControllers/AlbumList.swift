//
//  CategoryTableViewController.swift
//  AlanWalker
//
//  Created by Hady on 5/24/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class AlbumList: UITableViewController {
    //check napster Website
    //    var topTracks : [String] = ["faded","alone","the spectre","dark side"]
    var albumList :[String] = ["Single & ESP","Different World(2017)", "Something Up my Sleeve(2018)","Tired(Remix)", "Alone(Remix)", "Faded(Remix)" ,"Routine(Gamers Mix"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableView.separatorColor = .white
        
        
        tableView.rowHeight = 71.0
        tableView.tableFooterView = UIView()
        
        
    }
    
    // MARK: - TableView Data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albumList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = albumList[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Futura", size: 20.0)
        cell.backgroundColor = .none
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        performSegue(withIdentifier: "songsSegues", sender: self)
    //
    //    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SongsList
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.albumSelected = albumList[indexpath.row]
            
        }
    }
}
