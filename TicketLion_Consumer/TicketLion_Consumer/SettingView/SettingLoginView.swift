//
//  SettingLoginView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/06.
//

import SwiftUI

struct SettingLoginView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var isCompleteSignUp: Bool = false
    
    @Binding var isLoggedinUser: Bool
    
    @ObservedObject var userStore: UserStore
    
    var body: some View {
        VStack(spacing: 25) {
            Divider()
                .background(Color("AnyButtonColor"))
            Spacer()
            Image("AppIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .cornerRadius(20)
            Spacer()
            TextField("아이디 입력", text: $userEmail)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                )
                
            SecureField("비밀번호 입력", text: $userPassword)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            Button {
                userStore.login(email: userEmail, password: userPassword)
                if userStore.$currentUser != nil {
                    isLoggedinUser = true
                } else {
                    isLoggedinUser = false
                }
            } label: {
                Text("로그인")
            }
            .frame(maxWidth: .infinity, maxHeight: 20)
            .padding()
            .font(.title2)
            .foregroundColor(.white)
            .background(Color("AnyButtonColor"))
            .cornerRadius(5)
            .navigationDestination(isPresented: $isLoggedinUser, destination: {
                SettingView()
            })
            
            NavigationLink {
                SettingSignUpEmailView(isCompleteSignUp: $isCompleteSignUp, isLoggedinUser: $isLoggedinUser)
            } label: {
                Text("회원가입")
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.gray)
            .navigationTitle("로그인")
            Spacer()
        }
        .padding()
        
        Spacer()
    }
}

struct SettingLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingLoginView(isLoggedinUser: .constant(false), userStore: UserStore())
        }
    }
}
