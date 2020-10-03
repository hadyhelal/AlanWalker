//
//  SongsList.swift
//  AlanWalker
//
//  Created by Hady on 5/22/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import AVFoundation

class SongsList : UITableViewController , AVAudioPlayerDelegate ,ObservableObject {
    
    var musicVar = MusicData()
    var currentMusicArray = [MusicDataModel] ()
    var knowledge = delegateClass()
    
    var albumSelected : String? {
        didSet{
            loadData(album: (self.albumSelected)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.separatorColor = .white
        tableView.rowHeight = 91.0
        tableView.tableFooterView = UIView()
        print()
        
        // Registeration is to use it current class Bundle in register is to specify the location of the custom cell!
        tableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "MusicDataCell")
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMusicArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicDataCell", for: indexPath) as! TableViewCell1
        
        print("This ssss isss \(currentMusicArray.count) and index is \(indexPath.row)")
        cell.musicLabel.text = currentMusicArray[indexPath.row].musicName
        cell.musicLabel.textColor = .white
        cell.musicLabel.font = UIFont(name: "Futura", size: 20.0)
        
        cell.albumLabel.text = currentMusicArray[indexPath.row].musicAlbum
        cell.albumLabel.font = UIFont(name: "Futura", size: 20.0)
        
        cell.musicImage.image = UIImage(named: currentMusicArray[indexPath.row].musicImage)
        
        cell.playImage = UIImageView(image: UIImage(named: "play"))
        cell.backgroundColor = .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if knowledge.isWebView != nil && knowledge.isWebView == true {
            performSegue(withIdentifier: "", sender: self)
        }
        else {
            performSegue(withIdentifier: "musicUISeague", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Segue preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! musicUI
        if let index = tableView.indexPathForSelectedRow {
            destination.musicArray = currentMusicArray
            destination.currentIndexPath = index.row
        }
    }
      
    //MARK: - Load the music Data
    
    func loadData(album albumNameFetched : String, predicate: NSPredicate? = nil) {
        musicVar.list.forEach{
            if $0.musicAlbum == albumSelected {
                currentMusicArray.append($0)
            }
        }
        //        let pp = musicVar.list.filter { ( music ) -> Bool in
        //            return music.musicAlbum == albumSelected
        //        }
        //        print(pp.count)
        
    }
}


//MARK: - UISearchBar Functionality
extension SongsList : UISearchBarDelegate {
    
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        //let request : NSFetchRequest<Songs> = Songs.fetchRequest()
    //
    //        let predicate = NSPredicate(format: "songsName CONTAINS [cd] %@", searchBar.text!)
    //
    //        request.sortDescriptors = [NSSortDescriptor(key: "songsName", ascending: true)]
    //
    //        loadData(with: request , predicate: predicate)
    //    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchBar.text?.count == 0 {
    //            loadData()
    //
    //            DispatchQueue.main.async {
    //                searchBar.resignFirstResponder()
    //            }
    //        }
    //    }
}

