//
//  SignInViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit
import Supabase

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithApplePressed(_ sender: UIButton) {
        
        Task { @MainActor in
            let supabase = SupabaseClient(supabaseURL: URL(string: "https://jbigttrcudubidekcqnu.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpiaWd0dHJjdWR1YmlkZWtjcW51Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgzMjczMzQsImV4cCI6MjAxMzkwMzMzNH0.smoELkzmzlVHUR5iJdIGJze9YLzCnmv_Rd_vzjCMfVk")
            do {
                let url = try supabase.auth
                .getOAuthSignInURL(
                    provider: .apple
                )
                // ここでurlに遷移する
                print(url)
                self.performSegue(withIdentifier: "goToCreateProfile", sender: self)
            } catch {
                print("error")
            }
        }
    }
    
}
