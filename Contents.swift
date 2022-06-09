import Foundation

let queue = OperationQueue()
class AsyncOperation: Operation {
    //MARK: Properties
    private var _isExecuting = false
    override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        set {
            willChangeValue(for: \.isExecuting)
            _isExecuting = newValue
            didChangeValue(for: \.isExecuting)
        }
    }
    private var _isFinished = false
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            willChangeValue(for: \.isFinished)
            _isFinished = newValue
            didChangeValue(for: \.isFinished)
        }
    }
    //MARK: Methods
    override func start() {
        startOperation()
        main()
    }
    override func main() {
        //mocking aysnc task
        guard isCancelled == false else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            print("Operation COD underway")
            self.finishOperation()
        })
    }
    func startOperation() {
        isExecuting = true
        isFinished = false
    }
    func finishOperation() {
        isExecuting = false
        isFinished = true
    }
}

let testAsyncOp = AsyncOperation()
testAsyncOp.completionBlock = {
    print("Black op accomplished")
}
//queue.addOperation(testAsyncOp)

//BlockOps
let blockOp = BlockOperation {
    print("Block A")
}
blockOp.addExecutionBlock {
    print("Block B")
}
blockOp.addExecutionBlock {
    print("Block C")
}
blockOp.addExecutionBlock {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        print("Block D")
    })
}
blockOp.completionBlock = {
    print("All blcoks completed")
}
queue.addOperation(blockOp)
