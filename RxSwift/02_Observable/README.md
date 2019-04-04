# 02_Observable

 

### - What is Observable?

> Observable : 관찰할 수 있는

사전에서 알 수 있듯이 **Observable은 관찰할 수 있는 무언가** 이다.

  

> ReactiveX에서 옵저버는 Observable을 구독한다. Obseravable이 배출하는 하나 또는 연속된 항목에 옵저버는 반응한다. 

[ReactiveX 공식 홈페이지](http://reactivex.io/documentation/ko/observable.html) 에서는 Observable을 이렇게 설명한다.

**Observer** 는 **Observable** 을 **subscribe** 한다.

이것이 이번에 공부할 내용이다.

  

> 많은 코드를 살펴보다 보면, 개발자들은 자신의 코드가 점진적으로, 하나씩, 작성된 순서에 따라 실행되고 완료 되기를 기대한다는 사실을 쉽게 알 수 있다. 하지만, 이와 달리 ReactiveX에서는 "옵저버"에 의해 임의의 순서에 따라 병렬로 실행되고 결과는 나중에 연산된다. 즉, *메서드 호출* 보다는, "Observable" 안에 데이터를 조회하고 변환하는 메커니즘을 정의한 후, Observable이 이벤트를 발생시키면 옵저버의 관찰자가 그 순간을 감지하고 준비된 연산을 실행시켜 결과를 리턴하는 메커니즘 때문에, observable을 구독한다고 표현하는 것이 올바를 것이다.

위의 설명과 같이 ReactiveX에서는 메서드 호출 보다는, Observable안에 **데이터를 조회하고 변환하는 메커니즘을 정의** 한 후, Observable이 이벤트를 발생시키면 **Observer가 그 순간을 감지** 하고 준비된 연산을 실행시켜 결과를 리턴한다.

한마디로, ReactiveX에서는 Observable이라는 객체를 이용하여 값을 배출(emit)할 수 있고, Observer가 그 Observable을 Subscribe하여 그 값을 관찰하고 반응한다.

  

------

​     

### - Let's create Observable

- create

  ~~~swift
  let createObservable = Observable<String>.create {observer -> Disposable in
  			observer.on(.next("Danny"))
        observer.on(.completed)
        return Disposables.create()
  }.debug()
  ~~~

  가장 기본적인 Observable 생성 방법이다. 

  observer.on(.next())는 이벤트를 발생시킨다.

  observer.on(.completed)는 observer를 completed시킨다

- just

  ~~~swift
  let justObservable = Observable<String>.just("Danny")
  ~~~

  단일 이벤트를 발생하는 Observable 생성 방법이다.

- of

  ~~~swift
  let ofObservable1 = Observable.of("D","A","N","N","Y")
  let ofObservable2 = Observable.of(["D","A","N","N","Y"])
  ~~~

  주어진 값들에서 이벤트를 발생시킨다.

  ofObservable2의 타입은 Observable<[String]>이 된다. 배열을 넣을경우 하나의 배열이 통째로 이벤트를 발생시킨다.

- from

  ~~~swift
  let fromObservable = Observable.from(["D","A","N","N","Y"])
  ~~~

  from과 비슷하나 배열의 각 요소들로 하나씩 이벤트를 발생시킨다

  따라서 fromObservable의 타입은 Observable<String>이 된다. 

   

------

​      

### - Let's subscribe Observable

Observable은 단순히 Sequence의 정의일뿐이기 때문에 subscribe하기 전까지는 어떤 이벤트도 보내지 않는다.

> subscribe : 구독하다

~~~swift
Observable.of("D","A","N","N","Y")
  .subscribe { event in
    switch event {
    case .next(let value):
      print(value)
    case .error(let error):
      print(error)
    case .completed:
      print("completed")
    }
  }
~~~

우리는 Observable을 subscribe할 때 onNext, onError, onCompleted를 구현하게된다.

- onNext

  Observable은 새로운 항목들을 배출할 때마다 이 메서드를 호출한다. 이 메서드는 Observable이 배출하는 항목을 파라미터로 전달 받는다.

- onError

  오류가 발생할 경우 오류를 알리기 위해 이 메서드를 호출한다. 이 메서드가 호출되면 onNext나 onCompleted는 더 이상 호출되지 않는다. onError 메서드는 오류 정보를 저장하고 있는 객체를 파라미터로 전달 받는다.

- onCompleted

  오류가 발생하지 않았다면 Observable은 마지막 onNext를 호출한 후 이 메서드를 호출한다.

  

이에 따라서 Observable은

1. terminated 되기 전까지 onNext 메서드를 호출한다.
2. onCompleted 혹은 onError 메서드를 호출하면 terminated된다.
3. terminated 되면 더 이상 메서드를 호출하지 않는다.

  

------

  

### - Disposable

> Disposable: 사용 후 버리게 되어 있는

Observable은 terminated 된 후, disposed된다. 본인의 할 일을 다 끝냈으므로 버려지는 것이다.

Observable을 subscribe하면 Disposable을 반환된다.

~~~swift
Observable.of("D", "A", "N", "N", "Y")
		.subscribe{ print($0)}
		.dispose()
~~~

다음과 같은 방식으로 Observable을 dispose한다.

Observable을 subscribe하여 Disposable을 반환하는데, 이를 dispose 한 것이다.

  

각각의 구독에 관하여 일일이 관리하는 것은 효율적이지 못하기 때문에 DisposeBag을 사용할 수 있다.

~~~swift
let disposeBag = DisposeBag()

Observable.of("D", "A", "N", "N", "Y")
		.subscribe{ print($0)}
		.disposed(by: disposeBag)
~~~

disposeBag이 deinit() 될 때 dispose를 하므로 효율적으로 관리할 수 있다

  

------

  

### - Hot Observable, Cold Observable

- Hot Observable

  Hot Observable은 생성과 동시에 이벤트를 방출하기 시작한다.

  subcriber가 없어도 Observable의 이벤트는 계속된다.

  ex) 유튜브 라이브 생방송

    

- Cold Observable

  Cold Observable은 subscriber가 subscribe한 후부터 이벤트를 발생한다.

  ex) 유튜브 스트리밍