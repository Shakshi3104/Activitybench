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
// MARK: - VGG16
extension VGG16: UnifiedMLModel {
    var size: String {
        return "154MB"
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
        return "38.6MB"
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

// MARK: - ResNet 18
extension ResNet18: UnifiedMLModel {
    var size: String {
        return "15.4MB"
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
        return "4MB"
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

// MARK: - MobileNet
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

// MARK: PyramidNet 18
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
        return "459KB"
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

// MARK: - EfficientNet B0
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

// MARK: - MobileNetV2
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

extension MobileNetV2Int8: UnifiedMLModel {
    var size: String {
        return "7.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetV2Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetV2Int8Input(input: $0) })
        return outputs
    }
}

// MARK: - MobileNetV3 Small
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

extension MobileNetV3SmallInt8: UnifiedMLModel {
    var size: String {
        return "3.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MobileNetV3SmallInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MobileNetV3SmallInt8Input(input: $0) })
        return outputs
    }
}

// MARK: NASNet Mobile
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

extension NASNetMobileInt8: UnifiedMLModel {
    var size: String {
        return "4.9MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: NASNetMobileInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { NASNetMobileInt8Input(input: $0) })
        return outputs
    }
}

// MARK: - MnasNet
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

extension MnasNetInt8: UnifiedMLModel {
    var size: String {
        return "9.7MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MnasNetInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MnasNetInt8Input(input: $0) })
        return outputs
    }
}

// MARK: - DenseNet 121
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

extension DenseNet121Int8: UnifiedMLModel {
    var size: String {
        return "6.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: DenseNet121Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { DenseNet121Int8Input(input: $0) })
        return outputs
    }
}

// MARK: - Inception-v3
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

extension InceptionV3Int8: UnifiedMLModel {
    var size: String {
        return "14.7MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: InceptionV3Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { InceptionV3Int8Input(input: $0) })
        return outputs
    }
}

// MARK: - Xception
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

extension XceptionInt8: UnifiedMLModel {
    var size: String {
        return "21.3MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: XceptionInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { XceptionInt8Input(input: $0) })
        return outputs
    }
}

// MARK: - EfficientNet lite0
extension EfficientNetLite0: UnifiedMLModel {
    var size: String {
        return "43.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: EfficientNetLite0Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { EfficientNetLite0Input(input: $0) })
        return outputs
    }
}

extension EfficientNetLite0Int8: UnifiedMLModel {
    var size: String {
        return "11.2MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: EfficientNetLite0Int8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { EfficientNetLite0Int8Input(input: $0) })
        return outputs
    }
}

// MARK: - Simple CNN
extension SimpleCNN: UnifiedMLModel {
    var size: String {
        return "5.3MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: SimpleCNNInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { SimpleCNNInput(input: $0) } )
        return outputs
    }
}

extension SimpleCNNInt8: UnifiedMLModel {
    var size: String {
        return "1.3MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: SimpleCNNInt8Input(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { SimpleCNNInt8Input(input: $0) })
        return outputs
    }
}

// MARK: - MarNasNet-A
extension MarNASNetA: UnifiedMLModel {
    var size: String {
        return "1.3MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MarNASNetAInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MarNASNetAInput(input: $0) })
        return outputs
    }
}

// MARK: - MarNasNet-B
extension MarNASNetB: UnifiedMLModel {
    var size: String {
        return "448KB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MarNASNetBInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MarNASNetBInput(input: $0) })
        return outputs
    }
}

// MARK: - MarNASNet-C
extension MarNASNetC: UnifiedMLModel {
    var size: String {
        return "3.1MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MarNASNetCInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MarNASNetCInput(input: $0) })
        return outputs
    }
}

// MARK: - MarNASNet-E
extension MarNASNetE: UnifiedMLModel {
    var size: String {
        return "4.6MB"
    }
    
    func prediction(input: MLMultiArray) throws -> UnifiedModelOutput {
        let output = try self.prediction(input: MarNASNetEInput(input: input))
        return output
    }
    
    func predictions(inputs: [MLMultiArray]) throws -> [UnifiedModelOutput] {
        let outputs = try self.predictions(inputs: inputs.map { MarNASNetEInput(input: $0) })
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

extension MobileNetV2Int8Output: UnifiedModelOutput { }

extension MobileNetV3SmallOutput: UnifiedModelOutput { }

extension MobileNetV3SmallInt8Output: UnifiedModelOutput { }

extension NASNetMobileOutput: UnifiedModelOutput { }

extension NASNetMobileInt8Output: UnifiedModelOutput { }

extension MnasNetOutput: UnifiedModelOutput { }

extension MnasNetInt8Output: UnifiedModelOutput { }

extension DenseNet121Output: UnifiedModelOutput { }

extension DenseNet121Int8Output: UnifiedModelOutput { }

extension InceptionV3Output: UnifiedModelOutput { }

extension InceptionV3Int8Output: UnifiedModelOutput { }

extension XceptionOutput: UnifiedModelOutput { }

extension XceptionInt8Output: UnifiedModelOutput { }

extension EfficientNetLite0Output: UnifiedModelOutput { }

extension EfficientNetLite0Int8Output: UnifiedModelOutput { }

extension SimpleCNNOutput: UnifiedModelOutput { }

extension SimpleCNNInt8Output: UnifiedModelOutput { }

extension MarNASNetAOutput: UnifiedModelOutput { }

extension MarNASNetBOutput: UnifiedModelOutput { }

extension MarNASNetCOutput: UnifiedModelOutput { }

extension MarNASNetEOutput: UnifiedModelOutput { }
