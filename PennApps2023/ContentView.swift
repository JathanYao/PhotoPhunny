import SwiftUI
import PhotosUI
import FirebaseStorage

struct ContentView: View {
    @State private var tabSelected: Tab = .scroll
    @State private var showhome: Bool = true
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack {
            VStack {
                ZStack{
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            HStack {
                                if tab == .scroll {
                                    photoPicker()
                                }
                                if tab == .map {
                                    
                                }
                                
                                if tab == .trophy {
                                    
                                }
                                
                                if tab == .gearshape {
                                    
                                }
                            }
                            
                            .tag(tab)
                        }
                        
                    }
                    homepage(showhome: $showhome)
                }
                
            }
            VStack {
                Spacer()
                NavBar(selectedTab: $tabSelected, showhome: $showhome)
            }
        }
    }
}

struct homepage: View {
    @Binding var showhome: Bool
    var body: some View {
        if(showhome){
            ZStack{
                Image("bgimage").ignoresSafeArea()
                VStack{
                    Text("Welcome Back!")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 200)
                    Button("Enter"){
                        showhome = false
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.green)
                            .frame(width: 200, height: 50)
                    )
                    .padding(.top, 100)
                }
            }
        }
    }
}

struct photoPicker: View {
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    
    var body : some View {
        VStack  {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            
            Button {
                isPickerShowing = true
            } label: {
                Text("Select")
            }
            
            if selectedImage != nil {
                Button {
                    uploadPhoto()
                } label: {
                    Text("Upload photo")
                }
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
    }
    
    func uploadPhoto() {
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            
            if error == nil && metadata != nil {
                
            }
        }
    }
}


 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

