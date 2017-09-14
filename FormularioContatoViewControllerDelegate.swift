//
//  FormularioContatoViewControllerDelegation.swift
//  ContatosIP67
//
//  Created by ios7126 on 13/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate {
    func contatoAtualizado(_ contato:Contato)
    func contatoAdicionado(_ contato:Contato)
}
