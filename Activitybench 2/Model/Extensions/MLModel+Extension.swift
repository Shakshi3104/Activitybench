//
//  MLModel+Extension.swift
//  Activitybench 2
//
//  Created by MacBook Pro M1 on 2021/05/17.
//

import CoreML

// MARK: - Unified MLModel
protocol UnifiedMLModel {
    var size: String { get }
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput]
}

// MARK: - Unified ModelOutput
protocol UnifiedModelOutput {
    var Identity: [String: Double] { get }
    var classLabel: String { get }
}

// MARK: - Extend MLModel
extension VGG16: UnifiedMLModel {
    var size: String {
        return "18.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: VGG16Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { VGG16Input(input: $0) })
        return outputs
    }
}

extension VGG16Int8: UnifiedMLModel {
    var size: String {
        return "4.6MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: VGG16Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { VGG16Int8Input(input: $0) })
        return outputs
    }
}

extension ResNet18: UnifiedMLModel {
    var size: String {
        return "728KB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: ResNet18Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { ResNet18Input(input: $0) })
        return outputs
    }
}

extension ResNet18Int8: UnifiedMLModel {
    var size: String {
        return "465KB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: ResNet18Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { ResNet18Int8Input(input: $0) })
        return outputs
    }
}

extension MobileNet: UnifiedMLModel {
    var size: String {
        return "24MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetInput(input: $0) })
        return outputs
    }
}

extension MobileNetInt8: UnifiedMLModel {
    var size: String {
        return "6.2MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetInt8Input(input: $0) })
        return outputs
    }
}

extension PyramidNet18: UnifiedMLModel {
    var size: String {
        return "1.6MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: PyramidNet18Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { PyramidNet18Input(input: $0) })
        return outputs
    }
}

extension PyramidNet18Int8: UnifiedMLModel {
    var size: String {
        return "465KB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: PyramidNet18Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { PyramidNet18Int8Input(input: $0) })
        return outputs
    }
}

extension EfficientNetB0: UnifiedMLModel {
    var size: String {
        return "45.7MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: EfficientNetB0Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { EfficientNetB0Input(input: $0) })
        return outputs
    }
}

extension EfficientNetB0Int8: UnifiedMLModel {
    var size: String {
        return "12MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: EfficientNetB0Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { EfficientNetB0Int8Input(input: $0) })
        return outputs
    }
}

extension MobileNetV2: UnifiedMLModel {
    var size: String {
        return "26.9MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetV2Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetV2Input(input: $0) })
        return outputs
    }
}

extension MobileNetV3Small: UnifiedMLModel {
    var size: String {
        return "11.6MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetV3SmallInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetV3SmallInput(input: $0) })
        return outputs
    }
}

extension NASNetMobile: UnifiedMLModel {
    var size: String {
        return "16.5MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: NASNetMobileInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { NASNetMobileInput(input: $0) })
        return outputs
    }
}

extension MnasNet: UnifiedMLModel {
    var size: String {
        return "37.4MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MnasNetInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MnasNetInput(input: $0) })
        return outputs
    }
}

extension DenseNet121: UnifiedMLModel {
    var size: String {
        return "22.3MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: DenseNet121Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { DenseNet121Input(input: $0) })
        return outputs
    }
}

extension InceptionV3: UnifiedMLModel {
    var size: String {
        return "57.2MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: InceptionV3Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { InceptionV3Input(input: $0) })
        return outputs
    }
}

extension Xception: UnifiedMLModel {
    var size: String {
        return "82.7MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: XceptionInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { XceptionInput(input: $0) } )
        return outputs
    }
}

extension EfficientNet_lite0: UnifiedMLModel {
    var size: String {
        return "43.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: EfficientNet_lite0Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { EfficientNet_lite0Input(input: $0) })
        return outputs
    }
}

// MARK: - Extend ModelOutput
extension VGG16Output: UnifiedModelOutput { }

extension VGG16Int8Output: UnifiedModelOutput { }

extension ResNet18Output: UnifiedModelOutput { }

extension ResNet18Int8Output: UnifiedModelOutput { }

extension MobileNetOutput: UnifiedModelOutput { }

extension MobileNetInt8Output: UnifiedModelOutput { }

extension PyramidNet18Output: UnifiedModelOutput { }

extension PyramidNet18Int8Output: UnifiedModelOutput { }

extension EfficientNetB0Output: UnifiedModelOutput { }

extension EfficientNetB0Int8Output: UnifiedModelOutput { }

extension MobileNetV2Output: UnifiedModelOutput { }

extension MobileNetV3SmallOutput: UnifiedModelOutput { }

extension NASNetMobileOutput: UnifiedModelOutput { }

extension MnasNetOutput: UnifiedModelOutput { }

extension DenseNet121Output: UnifiedModelOutput { }

extension InceptionV3Output: UnifiedModelOutput { }

extension XceptionOutput: UnifiedModelOutput { }

extension EfficientNet_lite0Output: UnifiedModelOutput { }
