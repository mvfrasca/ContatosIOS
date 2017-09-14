//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7126 on 11/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Foundation

class FormularioContatoViewController: UIViewController, FormularioContatoViewControllerDelegate {

    var dao:ContatoDao
    var contato: Contato!
    var delegate:FormularioContatoViewControllerDelegate?
    
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
        
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormSegue" {
            if let formulario = segue.destination as? FormularioContatoViewController {
                formulario.delegate = self
            }
        }
    }
    
    func pegaDadosDoFormulario(){
        if contato == nil {
            self.contato = Contato()
        }
        
        contato.nome = self.nome.text!
        contato.telefone = self.telefone.text!
        contato.endereco = self.endereco.text!
        contato.site = self.site.text!
    }
    
    @IBAction func criaContato(){
        self.pegaDadosDoFormulario()
        dao.adiciona(contato)
        
        self.delegate?.contatoAdicionado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func atualizaContato(){
        pegaDadosDoFormulario()
        self.delegate?.contatoAtualizado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func contatoAtualizado(_ contato:Contato) {
        print("Contato atualizado: \(contato.nome)")
    }
    
    func contatoAdicionado(_ contato:Contato) {
        print("Contato adicionado: \(contato.nome)")
    }
    
}

