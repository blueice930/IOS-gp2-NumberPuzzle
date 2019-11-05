import Foundation

func randomize(level:Int) -> [Int]{
    let gridSize = level*level
    var grid = [Int](1...gridSize - 1).shuffled()
    let inversionCount = countInversionByMergeSort(array: grid).0
    
    if inversionCount % 2 == 0 {
        grid.append(0)
        return grid
    }else{
        let temp : Int = Int.random(in: 0 ..< gridSize - 2)
        grid.swapAt(temp, temp + 1)
        grid.append(0)
        return grid
    }
}

func countInversionByMergeSort(array arr: [Int]) -> (numOfInversions : Int , sortedArr : [Int] ){
    let length = arr.count
    
    if length == 1{
        return (0, arr)
    }
    
    let arrLeft = countInversionByMergeSort(array: Array(arr[0..<length/2]))
    let arrRight = countInversionByMergeSort(array: Array(arr[length/2..<length]))
    let leftLength = arrLeft.1.count
    var i = leftLength
    var j = 0
    var numOfInversions = arrLeft.0 + arrRight.0
    var arrSorted = [Int]()
    while i > 0 {
        if arrLeft.1[leftLength - i] < arrRight.1[j] {
            arrSorted.append(arrLeft.1[leftLength - i])
            i -= 1
        } else {
            arrSorted.append(arrRight.1[j])
            numOfInversions += i
            j += 1
            if j == arrRight.1.count {
                arrSorted += arrLeft.1[(leftLength - i)..<leftLength]
                break
            }
        }
    }
    if i == 0 {
        arrSorted += arrRight.1[j..<arrRight.1.count]
    }
    return (numOfInversions, arrSorted)
}




func printG(grid:[Int]){
    let L:Int = Int(Double(grid.count).squareRoot())
    for i in 0..<L {
        for j in 0..<L {
            print(grid[i * L + j ], terminator: "   ")
        }
        print("\n")
    }
}

func getIndex(num: Int, grid:[Int]) -> Int{
    return grid.firstIndex(of : num)!
}
func getRowColumn(index: Int, grid:[Int]) -> (Int,Int){
    let L:Int = Int(Double(grid.count).squareRoot())
    return (index/L, index%L)
}
func getRowColumn(num: Int, grid:[Int]) -> (Int,Int){
    let L:Int = Int(Double(grid.count).squareRoot())
    let index = getIndex(num: num, grid: grid)
    return (index/L, index%L)
}
func moveZero(targetPos:Int, currNumPos: Int, grid: inout [Int],freezed: inout [Int]) -> [Int]{
    let L:Int = Int(Double(grid.count).squareRoot())
    var steps = [Int]()
    //freeze the current number position
    freezed[currNumPos] = 1
    let targetRC = getRowColumn(index: targetPos, grid: grid)
    while getIndex(num: 0, grid: grid) != targetPos {
        //check direction currnumpos -> targetpos
        
        var columnFailed = true
        var rowFailed = true
        
        while getRowColumn(num: 0, grid: grid).1 > targetRC.1 {
            //compare column
            //target left
            
            if freezed[getIndex(num: 0, grid: grid) - 1] == 0{
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) - 1)
                steps.append(getIndex(num: 0, grid: grid))
                columnFailed = false
            }
            else{
                break
            }
        }
        
        while getRowColumn(num: 0, grid: grid).1 < targetRC.1 {
            //compare column
            //target right
            if freezed[getIndex(num: 0, grid: grid) + 1] == 0{
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + 1)
                steps.append(getIndex(num: 0, grid: grid))
                columnFailed = false
            }
            else{
                break
            }
        }
        if getRowColumn(num: 0, grid: grid).1 == targetRC.1 {
            //target same column
            while getRowColumn(num: 0, grid: grid).0 > targetRC.0 {
                //target up
                rowFailed = false
                if freezed[getIndex(num: 0, grid: grid) - L] == 0{
                    grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) - L)
                    steps.append(getIndex(num: 0, grid: grid))
                }
                else{
                    //move four steps: 0 to 5
                    //4 5 6
                    //3 1 2
                    //7 0 8
                    var upStep = [Int]()
                    if targetRC.1 + 1 == L {
                        //last column, then move : 7 3 4 5
                        upStep = [targetPos - 1 + 2*L, targetPos - 1 + L, targetPos - 1, targetPos]
                    } else{
                        //not last column, then move :8 2 6 5
                        upStep = [targetPos + 1 + 2*L, targetPos + 1 + L, targetPos + 1, targetPos]
                    }
                    for index in upStep{
                        grid.swapAt(getIndex(num: 0, grid: grid), index)
                    }
                    steps += upStep
                    break
                }
            }
            
            while getRowColumn(num: 0, grid: grid).0 < targetRC.0 {
                //compare row
                //target down
                rowFailed = false
                if freezed[getIndex(num: 0, grid: grid) + L] == 0{
                    grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + L)
                    steps.append(getIndex(num: 0, grid: grid))
                }
                else{
                    //move four steps: 0 to 5
                    //4 0 6
                    //3 1 2
                    //7 5 8
                    var downStep = [Int]()
                    if targetRC.1 + 1 == L {
                        //last column, then move : 4 3 7 5
                        downStep = [targetPos - 1 - 2*L, targetPos - 1 - L, targetPos - 1, targetPos]
                    } else{
                        //not last column, then move : 6 2 8 5
                        downStep = [targetPos + 1 - 2*L, targetPos + 1 - L, targetPos + 1, targetPos]
                    }
                    for index in downStep{
                        grid.swapAt(getIndex(num: 0, grid: grid), index)
                    }
                    steps += downStep
                    break
                }
            }
        }
        
        while getRowColumn(num: 0, grid: grid).0 > targetRC.0 {
            //compare row
            //target up
            if freezed[getIndex(num: 0, grid: grid) - L] == 0{
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) - L)
                steps.append(getIndex(num: 0, grid: grid))
                rowFailed = false
            }
            else{
                break
            }
        }
        
        
        while getRowColumn(num: 0, grid: grid).0 < targetRC.0 {
            //compare row
            //target down
            //print("down")
            
            if freezed[getIndex(num: 0, grid: grid) + L] == 0{
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + L)
                steps.append(getIndex(num: 0, grid: grid))
                rowFailed = false
            }
            else{
                break
            }
        }
        
        if getRowColumn(num: 0, grid: grid).0 == targetRC.0 {
            //compare row
            //target same row
            //print("same row")
            while getRowColumn(num: 0, grid: grid).1 > targetRC.1 {
                //compare column
                //target left
                columnFailed = false
                if freezed[getIndex(num: 0, grid: grid) - 1] == 0{
                    grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) - 1)
                    steps.append(getIndex(num: 0, grid: grid))
                }
                else{
                    //move four steps: 0 to 3
                    //4 2 6
                    //3 1 0
                    //7 5 8
                    var leftStep = [Int]()
                    if targetRC.0 + 1 == L {
                        //last row, then move : 6 2 4 3
                        leftStep = [targetPos + 2 - L, targetPos + 1 - L, targetPos - L, targetPos]
                    } else{
                        //not last row, then move : 8 5 7 3
                        leftStep = [targetPos + 2 + L, targetPos + 1 + L, targetPos + L, targetPos]
                    }
                    for index in leftStep{
                        grid.swapAt(getIndex(num: 0, grid: grid), index)
                    }
                    steps += leftStep
                    break
                }
            }
            
            while getRowColumn(num: 0, grid: grid).1 < targetRC.1 {
                //compare column
                //target right
                columnFailed = false
                if freezed[getIndex(num: 0, grid: grid) + 1] == 0{
                    grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + 1)
                    steps.append(getIndex(num: 0, grid: grid))
                }
                else{
                    //move four steps: 0 to 3
                    //4 2 6
                    //0 1 3
                    //7 5 8
                    var rightStep = [Int]()
                    if targetRC.0 + 1 == L {
                        //last row, then move : 4 2 6 3
                        rightStep = [targetPos - 2 - L, targetPos - 1 - L, targetPos - L, targetPos]
                    } else{
                        //not last row, then move : 7 5 8 3
                        rightStep = [targetPos - 2 + L, targetPos - 1 + L, targetPos + L, targetPos]
                    }
                    for index in rightStep{
                        grid.swapAt(getIndex(num: 0, grid: grid), index)
                    }
                    steps += rightStep
                    break
                }
            }
        }
        
        if rowFailed && columnFailed{
            
            if getRowColumn(index: grid[currNumPos] - 1, grid: grid).0 <= getRowColumn(index: grid[currNumPos] - 1, grid: grid).1 {
                //row loop
                
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + L)
                steps.append(getIndex(num: 0, grid: grid))
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + 1)
                steps.append(getIndex(num: 0, grid: grid))
            } else{
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + 1)
                steps.append(getIndex(num: 0, grid: grid))
                grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: 0, grid: grid) + L)
                steps.append(getIndex(num: 0, grid: grid))
            }
        }
    }
    
    freezed[currNumPos] = 0
    return steps
}




func normalMove(currNum: Int, numTarget: Int, zeroTarget: Int, grid: inout [Int], freezed: inout [Int]) -> [Int]{
    let L:Int = Int(Double(grid.count).squareRoot())
    var steps = [Int]()
    let targetRC = getRowColumn(index: numTarget, grid: grid)
    var tempZeroTarget: Int = 0
    while getIndex(num: currNum, grid: grid) != numTarget {
        //check the target num is in the row loop or column loop
        if targetRC.0 <= targetRC.1 {
            //row loop
            if getRowColumn(num: currNum, grid: grid).1 > targetRC.1 {
                //target left
                tempZeroTarget = getIndex(num: currNum, grid: grid) - 1
            } else if getRowColumn(num: currNum, grid: grid).1 < targetRC.1 {
                //target right
                tempZeroTarget = getIndex(num: currNum, grid: grid) + 1
            } else if getRowColumn(num: currNum, grid: grid).1 == targetRC.1 {
                //target same column
                
                if getRowColumn(num: currNum, grid: grid).0 > targetRC.0 {
                    //target up
                    tempZeroTarget = getIndex(num: currNum, grid: grid) - L
                } else{
                    //target down
                    tempZeroTarget = getIndex(num: currNum, grid: grid) + L
                }
            }
        } else{
            
            if getRowColumn(num: currNum, grid: grid).0 > targetRC.0 {
                //target up
                tempZeroTarget = getIndex(num: currNum, grid: grid) - L
            } else if getRowColumn(num: currNum, grid: grid).0 < targetRC.0 {
                //target down
                tempZeroTarget = getIndex(num: currNum, grid: grid) + L
            } else if getRowColumn(num: currNum, grid: grid).0 == targetRC.0 {
                //target same row
                if getRowColumn(num: currNum, grid: grid).1 < targetRC.1 {
                    //target right
                    tempZeroTarget = getIndex(num: currNum, grid: grid) + 1
                } else{
                    //target left
                    tempZeroTarget = getIndex(num: currNum, grid: grid) - 1
                }
            }
        }
        steps += moveZero(targetPos: tempZeroTarget, currNumPos: getIndex(num: currNum, grid: grid), grid: &grid, freezed: &freezed)
        // swap zero and currNum
        grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: currNum, grid: grid))
        steps.append(getIndex(num: 0, grid: grid))
    }
    //consider zero target now
    if (zeroTarget != -1)  || getIndex(num: 0, grid: grid) == zeroTarget{
        steps += moveZero(targetPos: zeroTarget, currNumPos: getIndex(num: currNum, grid: grid), grid: &grid, freezed: &freezed)
    }
    return steps
}

func move(currNum: Int, grid: inout [Int], freezed: inout [Int]) -> [Int]{
    let L:Int = Int(Double(grid.count).squareRoot())
    var steps = [Int]()
    let targetPos = currNum - 1
    let targetRC = getRowColumn(index: targetPos, grid: grid)
    if targetRC.1 == L - 1 {
        //target: up right corner
        
        if (targetPos + L == getIndex(num: currNum, grid: grid)) && targetPos == getIndex(num: 0, grid: grid) {
            grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: currNum, grid: grid))
            steps.append(getIndex(num: 0, grid: grid))
        } else{
            //normal move
            steps += normalMove(currNum: currNum, numTarget: targetPos + L - 1, zeroTarget: targetPos + L - 2, grid: &grid, freezed: &freezed)
            let upRightStep = [targetPos - 2, targetPos - 1, targetPos - 1 + L, targetPos + L, targetPos, targetPos - 1, targetPos - 2, targetPos - 2 + L]
            for index in upRightStep{
                grid.swapAt(getIndex(num: 0, grid: grid), index)
            }
            steps += upRightStep
        }
        
    }else if targetRC.0 == L - 1 {
        //target: bottom left corner
        if (targetPos + 1 == getIndex(num: currNum, grid: grid)) && targetPos == getIndex(num: 0, grid: grid) {
            grid.swapAt(getIndex(num: 0, grid: grid), getIndex(num: currNum, grid: grid))
            steps.append(getIndex(num: 0, grid: grid))
        } else{
            steps += normalMove(currNum: currNum, numTarget: targetPos + 2, zeroTarget: targetPos - L + 1, grid: &grid, freezed: &freezed)
            let downLeftStep = [targetPos - L, targetPos, targetPos + 1, targetPos - L + 1, targetPos - L, targetPos, targetPos + 1, targetPos + 2, targetPos + 2 - L, targetPos - L + 1, targetPos - L, targetPos, targetPos + 1]
            for index in downLeftStep{
                grid.swapAt(getIndex(num: 0, grid: grid), index)
            }
            steps += downLeftStep
        }
    }else{
        // normal cell
        steps += normalMove(currNum: currNum, numTarget: targetPos, zeroTarget: -1, grid: &grid, freezed: &freezed)
    }
    return steps
}

func getAns(grid: inout [Int]) -> [Int]{
    var ans = [Int]()
    var freezed = Array(repeating: 0, count: grid.count)
    let L:Int = Int(Double(grid.count).squareRoot())
    //print("L = ", L)
    for i in 0..<L - 1 {
        for j in 0..<L - i {
            var step = [Int]()
            if getIndex(num: i*(L + 1) + j + 1, grid: grid) != i*(L + 1) + j{
                step = move(currNum: i*(L + 1) + j + 1, grid: &grid, freezed: &freezed)
            }
            freezed[i*(L + 1) + j] = 1
            ans += step
            //            print("row step: ", step)
            //            print("grid: ",grid)
            //            printG(grid: grid)
            //            print("freezed: ", freezed)
            //            printG(grid: freezed)
        }
        
        for j in 0..<L - 1 - i {
            var step = [Int]()
            if getIndex(num: i*(L + 1) + (j+1)*L + 1, grid: grid) != i*(L + 1) + (j+1)*L{
                step = move(currNum:i*(L + 1) + (j+1)*L + 1, grid: &grid, freezed: &freezed)
            }
            freezed[i*(L + 1) + (j+1)*L] = 1
            ans += step
            //            print("column step: ", step)
            //            print("grid: ",grid)
            //            printG(grid: grid)
            //            print("freezed: ", freezed)
            //            printG(grid: freezed)
        }
    }
    return ans
}
