//
//  ContentsViewController.swift
//  TFM_EsterMartinez
//
//  Created by Ester on 11/7/17.
//  Copyright © 2017 Universitat Jaume I. All rights reserved.
//

import UIKit
import Firebase

class ContentsViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tablaContenidos: UITableView!
    @IBOutlet weak var orderBy: UISegmentedControl!
    @IBOutlet weak var buttonAdd: UIButton!
    
    var databaseRef: FIRDatabaseReference!
    
    var allContents = [String: Content]()
    var allContentsDate = [Double: Content]()
    var allContentsRate = [String: Content]()
    
    var orderedDates: [Double]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("anuncios/contenidos").observe(.value , with: { snapshot in
            
            let register = snapshot.value as? NSDictionary
            let contenidosID = register?.allKeys as? [NSString] ?? []
            
            for i in 0 ..< contenidosID.count {
                let contenidoData = register?.value(forKey: contenidosID[i] as String) as? NSDictionary
                
                let titulo = contenidoData?["titulo"] as! NSString
                let texto = contenidoData?["texto"] as! NSString
                let tipo = contenidoData?["tipo"] as! NSString
                let fecha = contenidoData?["fecha"] as! Double
                
                var contenido: Content!
                contenido.titulo = titulo
                contenido.texto = texto
                contenido.tipo = tipo
                contenido.fecha = fecha
                
                allContentsDate[fecha] = contenido
                allContents[contenidosID[i]] = contenido
                
                //NSDate(timeIntervalSince1970: intre2))
            }
            
            orderedDates = allContentsDate.keys.sorted()
            self.tablaContenidos.reloadData()
        })
            /*{ (error) in
                print(error.localizedDescription)
        }*/
        
        /*
        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [GroceryItem] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let groceryItem = GroceryItem(snapshot: item as! FIRDataSnapshot)
                newItems.append(groceryItem)
            }
            
            // 5
            self.items = newItems
            self.tableView.reloadData()
        })*/
        
        /*
 
 var prueba = [String: String]()
 
 prueba["ultimo"] = "Este es el ultimo elemento"
 prueba["elemento"] = "HOLA"
 prueba["probando"] = "Esto es una prueba"
 print("***********")
 
 let keys = prueba.keys
 let orderKeys = keys.sorted()
 print(orderKeys)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "contentCell")
        
        if (self.sender.selectedSegmentIndex == 0) {
            // "Recent" is selected
            let contenido = allContentsDate[orderedDates[indexPath.row]]
            
        
        }
        
        return cell
    }
    
    @IBAction func orderByChanged(_ sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            // "Recent" is selected
        }
        else {
            // "Popular" is selected
        }
    }

    @IBAction func addPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "content2addContent", sender: self)
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
