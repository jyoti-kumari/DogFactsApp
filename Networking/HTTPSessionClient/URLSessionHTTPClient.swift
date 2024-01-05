import Foundation
import PromiseKit

public final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSessionProtocol
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }
  
  // MARK: - HTTP Client
    func request<T: Decodable>(_ service: RequestProtocol, responseType: T.Type) -> Promise<T> {
        return Promise { seal in
            guard let url = buildURL(from: service) else {
                seal.reject(URLSessionHTTPClientError.invalidURL)
                return
            }
            session.dataTaskWithURL(url) { data, response, error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                Self.handleResponseData(data, responseType: responseType, seal: seal)
            }.resume()
        }
    }
}

private func buildURL(from service: RequestProtocol) -> URL? {
    var urlComponents = URLComponents(string: service.requestURL)
    var query = "apiKey=\(service.apiKey)"
    if !service.requestQueryParam.isEmpty {
        query = "\(query)&\(service.requestQueryParam)"
    }
    urlComponents?.query = query
    return urlComponents?.url
}

// MARK: - Response handlers
extension URLSessionHTTPClient {
    internal static func handleResponseData<T: Decodable>(_ data: Data?, responseType: T.Type, seal: Resolver<T>) {
        guard let data = data else {
            seal.reject(URLSessionHTTPClientError.noData)
            return
        }
        do {
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode(T.self, from: data)
            seal.fulfill(responseObject)
        } catch {
            seal.reject(URLSessionHTTPClientError.decodingError)
        }
    }
}
