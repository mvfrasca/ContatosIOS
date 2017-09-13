//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7126 on 11/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    var dao:ContatoDao
    
    @IBOutlet var nome:         UITextField!
    @IBOutlet var telefone:     UITextField!
    @IBOutlet var endereco:     UITextField!
    @IBOutlet var site:         UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pegaDadosDoFormulario(){
        let contato: Contato = Contato()
        
        contato.nome = self.nome.text!
        contato.telefone = self.telefone.text!
        contato.endereco = self.endereco.text!
        contato.site = self.site.text!
        
        dao.adiciona(contato)
        print(dao.contatos)
        
//        print("Nome: \(nome), Telefone: \(telefone), Endereço: \(endereco), Site: \(site)")
//        print(contato)
    }


}

