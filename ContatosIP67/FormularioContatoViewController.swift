//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7126 on 9/12/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //Declaração de variáveis
    var dao:ContatoDao
    var contato:Contato!
    var delegate:FormularioContatoViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder){
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var latitude: UITextField!
    @IBOutlet var longitude: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    @IBAction func criarContato(){
        self.pegaDadosFormulario()
        dao.adiciona(contato)
        
        //aciona delegate
        self.delegate?.contatoAdicionado(contato)
        
        _ = self.navigationController?.popViewController(animated: true)
        
        //Apenas imprime para validar os dados
        //print(self.contato)
        for contato in dao.contatos {
         print(contato)
         }
    }
    
    func pegaDadosFormulario(){
        
        if contato == nil{
            //self.contato = Contato()
            self.contato = dao.novoContato()
        }
        
        self.contato.nome = self.nome.text!
        self.contato.telefone = self.telefone.text!
        self.contato.endereco = self.endereco.text!
        self.contato.site = self.site.text!
        self.contato.foto = self.imageView.image
        
        if let latitude = Double(self.latitude.text!) {
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.longitude.text!) {
            self.contato.longitude = longitude as NSNumber
        }
    }

    //Metodo chamado toda vez que o formulario é carregado pela primeira vez
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mostrar contato na tela.
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            self.latitude.text = contato.latitude?.description
            self.longitude.text = contato.longitude?.description
            
            if let foto = self.contato.foto {
                self.imageView.image = foto
            }
            
            //Altera dinamicamente o botão adicionar para confirmar, caso o objeto contato esteja preenchido.
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            self.navigationItem.rightBarButtonItem = botaoAlterar
            
        }
        
        //Adicionar gesto de Tap à ImageView
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)
    }
    
    func selecionarFoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //Câmera disponível
        } else {
            //Câmera indisponível - utilizar biblioteca
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String :AnyObject]){
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = imagemSelecionada
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func atualizaContato(){
        pegaDadosFormulario()
        //aciona delegate
        self.delegate?.contatoAtualizado(contato)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buscarCoordenadas(sender: UIButton){
        
        sender.isHidden = true
        //sender.isEnabled = false
        self.loading.startAnimating()
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.endereco.text!) { (resultado, error) in
            
            if error == nil && (resultado?.count)! > 0 {
                let placemark = resultado![0]
                let coordenada = placemark.location!.coordinate
                
                self.latitude.text = coordenada.latitude.description
                self.longitude.text = coordenada.longitude.description
            }
            
            self.loading.stopAnimating()
            sender.isHidden = false
            //sender.isEnabled = true
        }
    }
}
