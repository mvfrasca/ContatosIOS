//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios7126 on 12/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: NSObject {

    static private var defaultDAO: ContatoDao!
    var contatos: Array<Contato>
    
    static func sharedInstance() -> ContatoDao{
        
        if defaultDAO == nil {
            defaultDAO = ContatoDao()
        }
        
        return defaultDAO
    }
    
    override private init(){
        self.contatos = Array()
        super.init()
    }
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)        
    }
    
    func listaTodos() -> [Contato] {
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int) -> Contato {
        return contatos[posicao]
    }
    
    func remove(_ posicao:Int){
        contatos.remove(at:posicao)
    }
    
}
