//
//  ContatosNoMapaViewController.swift
//  ContatosIP67
//
//  Created by ios7126 on 15/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    let localtionManager = CLLocationManager()
    var contatos: [Contato] = Array()
    let dao:ContatoDao = ContatoDao.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapa.delegate = self
        self.localtionManager.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.contatos = dao.listaTodos()
        self.mapa.addAnnotations(self.contatos)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(self.contatos)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapview: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier:String = "pino"
        var pino:MKPinAnnotationView
        
        if let reusablePin = mapview.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            pino = reusablePin
        } else {
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contato = annotation as? Contato {
            pino.pinTintColor = UIColor.cyan
            pino.canShowCallout = true
            
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let imagemContato = UIImageView(frame: frame)
            
            imagemContato.image = contato.foto
            pino.leftCalloutAccessoryView = imagemContato
        }
        
        return pino
        
    }
    
    func mapView(_ mapview: MKMapView, didSelect view: MKAnnotationView) {
        // Recupera o pino que foi selecionado
        let pino = view.annotation
        
        
        // Define os limites do zoom
//        let frame = CGRect(x: (pino?.coordinate.latitude)!, y: (pino?.coordinate.longitude)!, width: 100.0, height: 100.0)
//        var limiteHorizontalVertical: UILayoutPriority = UILayoutPriority()
//        limiteHorizontalVertical.add(10)
//        
//        mapview.systemLayoutSizeFitting(frame, withHorizontalFittingPriority: limiteHorizontalVertical, verticalFittingPriority: limiteHorizontalVertical)
        mapview.showAnnotations([pino!], animated: true)
        mapview.selectAnnotation(pino!, animated: true)
        
        // OU
        
//        let span = MKCoordinateSpanMake(0.5, 0.5)
//        // ou
//        let span = mapview.region.span
//        
//        
//        // Move o mapa
//        let region = MKCoordinateSpanMake(<#T##latitudeDelta: CLLocationDegrees##CLLocationDegrees#>, <#T##longitudeDelta: CLLocationDegrees##CLLocationDegrees#>)
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
