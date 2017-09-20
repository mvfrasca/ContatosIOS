//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios7126 on 9/12/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: CoreDataUtil {
    
    var contatos: Array<Contato>
    
    override private init(){
        self.contatos = Array()
        super.init()
        self.inserirDadosIniciais()
        //print("Caminho do BD:\(NSHomeDirectory())")
        self.carregaContatos()
    }
    
    //Singleton= garante uma unica instancia da classe.
    static private var defaultDAO: ContatoDao!
    
    static func sharedInstance() -> ContatoDao{
        
        if defaultDAO == nil {
            defaultDAO =  ContatoDao()
        }
        return defaultDAO
    }
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int) -> Contato {
        return contatos[posicao]
    }
    
    func remove(_ posicao:Int){
        persistentContainer.viewContext.delete(contatos[posicao])
        contatos.remove(at:posicao)
        ContatoDao.sharedInstance().saveContext()
    }
    
    func buscaPosicaoDoContato(_ contato: Contato) -> Int {
        return contatos.index(of: contato)!
    }
    
    func inserirDadosIniciais(){
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "São Paulo, SP, Rua Vergueiro, 3185"
            caelumSP.telefone = "01155712751"
            caelumSP.site = "http://www.caelum.com.br"
            caelumSP.latitude = -23.5883034
            caelumSP.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
            
        }
    }
    
    func carregaContatos(){
        let busca = NSFetchRequest<Contato>(entityName: "Contato")
        let orderPorNome = NSSortDescriptor(key: "nome", ascending: true)
        
        busca.sortDescriptors = [orderPorNome]
        
        do {
            self.contatos = try self.persistentContainer.viewContext.fetch(busca)
        } catch let error as NSError {
            print("Fetch falhou: \(error.localizedDescription)")
        }
            
    }
    
    func novoContato() -> Contato{
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
    }
    
}
