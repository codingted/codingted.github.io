## singlton 引用 prototype

实现ApplicationContexAware接口


InitializingBean 不用在指定 init方法了

<bean id="exampleInitBean" class="examples.ExampleBean" init-method="init"/>

DisposableBean

<bean id="exampleInitBean" class="examples.ExampleBean" destroy-method="cleanup"/>
