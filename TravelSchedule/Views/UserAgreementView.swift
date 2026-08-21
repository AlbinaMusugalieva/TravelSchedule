//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.ypWhite)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.ypBlack)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("Данный документ является действующим, если расположен по адресу: https://yandex.ru/legal/practicum_offer\n\nРоссийская Федерация, город Москва")
                        
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                            .padding(.bottom, 8)
                        
                        Text("1. ТЕРМИНЫ")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.ypBlack)
                        
                        Text("Понятия, используемые в Оферте, означают следующее:\n\nАвторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.\n\nВводный курс — начальный Курс обучения по представленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения, который предоставляется Студенту единожды при регистрации на Сервисе на безвозмездной основе. В процессе обучения в рамках Вводного курса Студенту предоставляется возможность ознакомления с работой Сервиса и определения возможности Студента продолжить обучение в рамках Полного курса по выбранной Студентом Программе обучения. Точное количество часов обучения в рамках Вводного курса зависит от выбранной Студентом Профессии или Курса и определяется в Программе обучения, размещенной на Сервисе. Максимальный срок освоения Вводного курса составляет 1 (один) год с даты начала обучения.")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                        
                    }
                    .padding([.horizontal,.top], 16)
                }
            }
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.ypBlack)
                    }
                }
            }
        }
    }
}
