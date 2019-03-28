# 01_RxSwift란?

 

### - What is RxSwift?

##### Rx + Swift

 

------

### - What is Rx?

Reactive + eXtensions

[ReactiveX](http://reactivex.io)페이지에선 Rx를

> An API for asynchronous programming with observable streams
>
> (관찰가능한 스트림으로 비동기 프로그래밍을 하는 하나의 API)

라고 소개한다.

  

------

### - Why Rx?

Apple 에서도 asynchronous programming(비동기 프로그래밍)을 지원하는 API가 있다.

- Notification Center : 

  RxSwift에선 구독하기 위해 subscribe 메소드 하나를 호출하면 되지만, Notification Center는 관찰자를 구독하기 위해 4개의 파라미터가 필요하다.

- Delegate Pattern : 

  ```swift
  extension ViewController: UIViewController, UITableViewDelegate, GoogleMapDelegate, UIDeviceOrientationDelegate {
    // 많은 메소드들이 요구된다.
  }
  ```

  여러가지 델리게이트를 사용함에 따라 수 많은 메소드들이 요구되게 된다.

  또한, 임의의 시간에 실행될 메소드를 정의하지만, 언제 실행되는지, 언제 실행될 지 알 수 없다.

- Grand Central Dispatch(GCD), Closure ...

다음과 같이 RxSwift가 그 외의 비동기 프로그래밍을 돕는 API보다 더 편리하기 때문에 RxSwift를 많이 사용한다.

 

------

### - Functional Reactive Programming

Functional Reactive Programming은 OOP처럼 하나의 개발 패러다임이다.

여기서 Swift는 이미 Functional Programming을 지원하고 있고, Reactive Programming을 위해 RxSwift를 사용하는 것이다.

그렇다고 Reactive Programming을 Rx라고 생각하면 안된다. Rx는 단순히 Reactive Programming을 도와주는 일종의 **API** 이다.

 

------

### - Reactive Programming (반응형 프로그래밍)

이해하기 쉽게 우리가 자주 사용하는 명령형 프로그래밍과 비교해보면

~~~swift
a = 0
b = 1
c = 2
a = b + c
print(a) //3
c = 100
print(a) //3
~~~

[명령형 프로그래밍]

  

~~~swift
a = 0
b = 1
c = 2
a = b + c
print(a) //3
c = 100
print(a) //101
~~~

[반응형 프로그래밍]

 이런 식으로 비교할 수 있다.

우리가 흔히 볼 수 있는 스프레드 시트 또한 반응형 프로그래밍이라고 할 수 있다.

 

------

따라서 결론적으로

#### RxSwift란 Swift로 Reactive Programming을 할 수 있도록 도와주는 하나의 API이다.