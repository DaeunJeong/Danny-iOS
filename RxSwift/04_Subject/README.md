# 04_Subject

​        

### - What is Subject?

[Observable](https://github.com/DaeunJeong/Danny-iOS/blob/master/RxSwift/03_Operators/README.md) 에서 Hot Observable과 Cold Observable에 대해서 배웠는데, Subject는 **Cold Observable을 Hot하게 변형** 해준다. Subject는 **Observable과 Observer 두 역할을 수행** 한다. 관찰 할 수도, 관찰 당할 수도 있다.

Subject에는 PublishSubject, BehaviorSubject, ReplaySubject, Variable 총 네가지 종류의 Subject가 존재한다.

​          

------

​          

### - PublishSubject

PublishSubject는 **subscribe 된 이후** 부터 발생한 이벤트를 전달한다.

그 이전의 이벤트는 전달하지않는다.

~~~swift
let disposeBag = DisposeBag()
let publishSubject = PublishSubject<Int>()


publishSubject.subscribe{ print("First: \($0)") }
    .disposed(by: disposeBag)

publishSubject.onNext(1)
publishSubject.onNext(2)

publishSubject.subscribe{ print("Second: \($0)") }
    .disposed(by: disposeBag)

publishSubject.onNext(3)
publishSubject.onNext(4)
publishSubject.onCompleted()

//print
First: 1
First: 2
First: 3
Second: 3
First: 4
Second: 4
~~~

​        

------

​        

### - BehaviorSubject

BehaviorSubject는 구독 후 가장 최근의 이벤트를 전달한다.

~~~swift
let disposeBag = DisposeBag()
let behaviorSubject = BehaviorSubject(value: 0)


behaviorSubject.subscribe{ print("First: \($0)") }
    .disposed(by: disposeBag)

behaviorSubject.onNext(1)
behaviorSubject.onNext(2)

behaviorSubject.subscribe{ print("Second: \($0)") }
    .disposed(by: disposeBag)

behaviorSubject.onNext(3)
behaviorSubject.onNext(4)
behaviorSubject.onCompleted()

//print
First: 0
First: 1
First: 2
Second: 2
First: 3
Second: 3
First: 4
Second: 4
~~~



​            

------

​          

### - ReplaySubject

ReplaySubject는 설정한 BufferSize만큼 가장 최근의 이벤트를 전달한다.

~~~swift
let disposeBag = DisposeBag()
let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)


replaySubject.subscribe{ print("First: \($0)") }
    .disposed(by: disposeBag)

replaySubject.onNext(1)
replaySubject.onNext(2)
replaySubject.onNext(3)

replaySubject.subscribe{ print("Second: \($0)") }
    .disposed(by: disposeBag)

replaySubject.onNext(4)
replaySubject.onNext(5)
replaySubject.onCompleted()

//print
First: 1
First: 2
First: 3
Second: 2
Second: 3
First: 4
Second: 4
First: 5
Second: 5
~~~

​      

------

​         

### - Variable

Variable은 BehaviorSubject를 감싸는 .onNext만 발생시킬 수 있는 Wrapper이다.

할당 해제될 때 자동으로 .onCompleted가 발생한다.

BehaviorSubject를 더 쉽게 사용하기 위해 만들어졌다.

~~~swift
let disposeBag = DisposeBag()
let variable = Variable(0)
variable.asObservable().subscribe { print("First : \($0)") }
    .disposed(by: disposeBag)

variable.value = 1
variable.value = 2

variable.asObservable().subscribe { print("Second : \($0)") }
    .disposed(by: disposeBag)

variable.value = 3
variable.value = 4

//print
First: 0
First: 1
First: 2
Second: 2
First: 3
Second: 3
First: 4
Second: 4
~~~

Variable에는 value라는 프로퍼티를 가지는 것이 특징이다.

​      

------

​      

### - Relay

예제를 보면 Relay 또한 많이 쓰인다는 것을 볼 수 있다.

Relay는 Subject를 감싼 Wrapper 클래스이다. 

Relay는 Subject와 다르게 RxCocoa의 클래스이고, error또는  complete로 완전 종료될 수 없다.

