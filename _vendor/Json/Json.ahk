/*
  https://stackoverflow.com/questions/33989042/json-parsing-generating-and-beautifiying-formatting-with-autohotkey#answer-33989043
  */

class Json {
    __New(indent="    ",newLine="`r`n") { ;default indent: 4 spaces. default newline: crlf
        this.ind := indent
        this.nl := newLine
    }

    getIndents(num) {
        indents := ""
        Loop % num
            indents .= this.ind
        Return indents
    }

    jsonFileToObj(fileFullPath) {
        file := FileOpen(fileFullPath, "r")
        Return this.jsonToObj(file.Read()), file.Close()
    }

    objToJsonFile(obj,fileFullPath) {
        FileDelete, % fileFullPath
        SplitPath, fileFullPath,, dir
        FileCreateDir % dir
        file := FileOpen(fileFullPath, "w")
        Return file.write(this.objToJson(obj)), file.Close()
    }

    objToJson(obj,indNum:=0) {
        indNum++
        str := "" , array := true
        for k in obj {
            if (k == A_Index)
                continue
            array := false
            break
        }
        for a, b in obj
            str .= this.getIndents(indNum) . (array ? "" : """" a """: ") . (IsObject(b) ? this.objToJson(b,indNum) : this.isNumber(b) ? b : """" StrReplace(b,"""","\""") """") . ", " this.nl
        str := RTrim(str, " ," this.nl)
        return (array ? "[" this.nl str this.nl this.getIndents(indNum-1) "]" : "{" this.nl str this.nl this.getIndents(indNum-1) "}") ;"
    }

    jsonToObj(jsonStr) {
        SC := ComObjCreate("ScriptControl") 
        SC.Language := "JScript"
        ComObjError(false)
        jsCode =
        (
        function arrangeForAhkTraversing(obj) {
            if(obj instanceof Array) {
                for(var i=0 ; i<obj.length ; ++i)
                    obj[i] = arrangeForAhkTraversing(obj[i]) ;
                return ['array',obj] ;
            } else if(obj instanceof Object) {
                var keys = [], values = [] ;
                for(var key in obj) {
                    keys.push(key) ;
                    values.push(arrangeForAhkTraversing(obj[key])) ;
                }
                return ['object',[keys,values]] ;
            } else
                return [typeof obj,obj] ;
        }
        )
        SC.ExecuteStatement(jsCode "; obj=" jsonStr)
        return this.convertJScriptObjToAhkObj( SC.Eval("arrangeForAhkTraversing(obj)") )
    }

    convertJScriptObjToAhkObj(jsObj) {
        if(jsObj[0]="object") {
            obj := {}, keys := jsObj[1][0], values := jsObj[1][1]
            loop % keys.length
                obj[keys[A_INDEX-1]] := this.convertJScriptObjToAhkObj( values[A_INDEX-1] )
            return obj
        } else if(jsObj[0]="array") {
            array := []
            loop % jsObj[1].length
                array.insert(this.convertJScriptObjToAhkObj( jsObj[1][A_INDEX-1] ))
            return array
        } else
            return jsObj[1]
    }

    isNumber(Num) {
        if Num is number
            return true
        else
            return false
    }
}




/**
	CALL CLASS FUNCTION
*/
Json(indent="    ",newLine="`r`n"){
	return % new Json(indent,newLine)
}





