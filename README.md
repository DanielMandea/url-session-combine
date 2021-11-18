# CombineURLSession

Use this package in order to ease up working with `Combine` URLSession. 
We support working with `Codable` for all main `HTTP` methods `GET`, `POST`, `PUT` and `DELETE`.
We also support MultipartUpload 

## Instalation 

To  install this package just add the follwing in yor package 

``` swift 
.package(url: "https://github.com/DanielMandea/url-session-combine.git", from: "1.0.0"),
```

## Usage

Define SomeService Example
```swift

class SomeService: BaseService {
    
    // MARK: - Session
    
    let sessionProvider: SessionProvider
    
    // MARK: - Init
    
    init(api: API = ServiceConfiguration.api, sessionProvider: SessionProvider = DefaultSessionProvider(authenticatorProvider: Authenticator())) {
        self.sessionProvider = sessionProvider
        super.init(api: api)
    }
    
    func get<T: Codable>(for path: String, headers: [String: String] = ["Content-Type":"application/json"], decoder: JSONDecoder = JSONDecoder.iso8601JsonDecoder) -> AnyPublisher<T, Error> {
        Publishers.CombineLatest(just(path: path), sessionProvider.jwt()).flatMap {
            self.get(from: $0, headers: self.merge(jwt: $1, with: headers), decoder: decoder)
        }.eraseToAnyPublisher()
    }
}
```

Call SomeService Example

```swift
    get(for: "somepath/", decoder: JSONDecoder.iso8601FullDateJsonDecoder)
```

Multipart Upload Example
```swift
    Publishers.CombineLatest(just(path: athletes), sessionProvider.jwt()).map {
        URLRequest.multipart(for: $0, 
                          method: .POST, 
                          headers: ["Authorization": $1, "Accept-Encoding": "gzip, deflate, br"], 
                          payload: value, 
                          multiparts: [Multipart(key: "profilePhoto", data: profileImageData, mimeType: .jpeg, fileName: "\(UUID().uuidString).jpeg")],
                          encoder: JSONEncoder.iso860JSONEncoder, 
                          decoder: JSONDecoder.iso8601FullDateJsonDecoder)
    }.flatMap {
        self.task(for: $0, decoder: JSONDecoder.iso8601FullDateJsonDecoder)
    }
    .eraseToAnyPublisher()
```
