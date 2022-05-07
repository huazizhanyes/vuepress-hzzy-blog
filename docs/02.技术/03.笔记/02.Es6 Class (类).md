---
title: Es6 Class (类)
date: 2022-05-07 11:05:52
permalink: /pages/ddf226/
categories:
  - 技术
  - 笔记
tags:
  - 
author: 
  name: Teddy是一只熊
---

在ES6中，class (类)作为对象的模板被引入，可以通过 class 关键字定义类。

class 的本质是 function。

它可以看作一个语法糖，让对象原型的写法更加清晰、更像面向对象编程的语法

```js
class Example {
  a = 3;
  constructor() {
    console.log(this.a);
  }
}
new Example()
```

<!-- more -->

class  定义不会被提升  访问前要对类定义

实例化必须要用new 关键字

constructor 方法是类的默认方法，创建类的实例化对象时被调用

static 在constructor 方法外可用

静态方法

```js
class Example{    
    static sum(a, b) {
        console.log(a+b);    
    } 
} 
Example.sum(1, 2); // 3
```

原型方法

```js
class Example {
    sum(a, b) {
        console.log(a + b);
    }
}
let exam = new Example();
exam.sum(1, 2); // 3
```

实例方法

```js
class Example {
    constructor() {
        this.sum = (a, b) => {
            console.log(a + b);
        }
    }
}
let exam = new Example();
exam.sum(1, 2); // 3
```

共享原型对象

```js
class Example {
    constructor(a, b) {
        this.a = a;
        this.b = b;
        console.log('Example');
    }
    sum() {
        return this.a + this.b;
    }
}
let exam1 = new Example(2, 1);
let exam2 = new Example(3, 1);
console.log(exam1._proto_ == exam2._proto_); // true
 
exam1._proto_.sub = function() {
    return this.a - this.b;
}
console.log(exam1.sub()); // 1
console.log(exam2.sub()); // 2
```

## decorator

decorator 是一个函数，用来修改类的行为，在代码编译时产生作用。

### 类修饰

一个参数

第一个参数 target，指向类本身。

```js
function testable(target) {
    target.isTestable = true;
}
@testable
class Example {}
Example.isTestable; // true
```

多个参数——嵌套实现

```js
function testable(isTestable) {
    return function(target) {
        target.isTestable=isTestable;
    }
}
@testable(true)
class Example {}
Example.isTestable; // true
```

### 方法修饰

3个参数：target（类的原型对象）、name（修饰的属性名）、descriptor（该属性的描述对象）。

```js
class Example {
    @writable
    sum(a, b) {
        return a + b;
    }
}
function writable(target, name, descriptor) {
    descriptor.writable = false;
    return descriptor; // 必须返回
}
```

修饰器执行顺序

由外向内进入，由内向外执行。

```js
class Example {
    @logMethod(1)
    @logMethod(2)
    sum(a, b){
        return a + b;
    }
}
function logMethod(id) {
    console.log('evaluated logMethod'+id);
    return (target, name, desctiptor) => console.log('excuted         logMethod '+id);
}
// evaluated logMethod 1
// evaluated logMethod 2
// excuted logMethod 2
// excuted logMethod 1
```

### extends

通过 extends 实现类的继承。

```js
class Child extends Father { ... }
```

### super

子类 constructor 方法中必须有 super ，父类的构造函数，用来新建父类的`  this 对象且必须出现在 this 之前。

```js
class Father {
    constructor(){}
    get a() {
        return this._a;
    }
}
class Child extends Father {
    constructor(){
        super();
    }
    set a(a) {
        this._a = a;
    }
}
let test = new Child();
test.a = 2;
console.log(test.a); // undefined
 
class Father1 {
    constructor(){}
    // 或者都放在子类中
    get a() {
        return this._a;
    }
    set a(a) {
        this._a = a;
    }
}
class Child1 extends Father1 {
    constructor(){
        super();
    }
}
let test1 = new Child1();
test1.a = 2;
console.log(test1.a); // 2
```

Father1 是表达式，不是方法，不能以函数的方式调用。。。。。

### 注意要点

不可继承常规对象。

```js
var Father = {
    // ...
}
class Child extends Father {
     // ...
}
// Uncaught TypeError: Class extends value #<Object> is not a constructor or null
 
// 解决方案
Object.setPrototypeOf(Child.prototype, Father);
```

