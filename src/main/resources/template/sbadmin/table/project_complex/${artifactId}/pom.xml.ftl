<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>${groupId}</groupId>
    <artifactId>${artifactId}</artifactId>
    <version>${mvnVersion?default('1.0-SNAPSHOT')}</version>

    <packaging>pom</packaging>

    <#if (mvnURL)??>
    <url>${mvnURL}</url>
    </#if>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.build.sourceVersion>1.7</project.build.sourceVersion>
        <project.build.targetVersion>1.7</project.build.targetVersion>
        <spring.version>4.1.9.RELEASE</spring.version>
        <servlet.api.version>3.0.1</servlet.api.version>
        <dependency.junit.version>4.12</dependency.junit.version>
        <fasterxml.jackson.databind.version>2.7.5</fasterxml.jackson.databind.version>
        <hibernate.validator.version>5.2.4.Final</hibernate.validator.version>
        <javax.validation.version>1.1.0.Final</javax.validation.version>
        <javax.el.version>3.0.0</javax.el.version>
        <maven-javadoc-plugin.version>2.9.1</maven-javadoc-plugin.version>
        <maven-source-plugin.version>2.2.1</maven-source-plugin.version>
        <maven-compiler-plugin.version>3.1</maven-compiler-plugin.version>
        <findbugs-maven-plugin.version>2.5.5</findbugs-maven-plugin.version>
        <org.aspectj.version>1.7.4</org.aspectj.version>
        <bonecp.version>0.8.0.RELEASE</bonecp.version>
        <logback.version>1.1.7</logback.version>
    <#if spring_viewresolver?lower_case?trim == 'velocity'>
        <velocity-dep.version>1.4</velocity-dep.version>
        <velocity-tools.version>2.0</velocity-tools.version>
        <velocity.version>1.7</velocity.version>
    </#if>
    <#if support_Shiro == "true">
        <shiro.version>1.2.5</shiro.version>
    </#if>
    <#if support_Dubbo == "true">
        <dubbo.version>2.5.3</dubbo.version>
        <zkclient.version>0.10</zkclient.version>
    </#if>

    </properties>

    <modules>
        <module>${artifactId}-service</module>
        <module>${artifactId}-web</module>
        <module>${artifactId}-provider</module>
        <module>${artifactId}-domain</module>
        <module>${artifactId}-common</module>
    </modules>
    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version><#noparse>${maven-compiler-plugin.version}</#noparse></version>
                    <configuration>
                        <source><#noparse>${project.build.sourceVersion}</#noparse></source>
                        <target><#noparse>${project.build.targetVersion}</#noparse></target>
                        <encoding><#noparse>${project.build.sourceEncoding}</#noparse></encoding>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-source-plugin</artifactId>
                    <version><#noparse>${maven-source-plugin.version}</#noparse></version>
                    <executions>
                        <execution>
                            <id>attach-source</id>
                            <phase>package</phase>
                            <goals>
                                <goal>jar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                <plugin>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <configuration>
                      <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                      </descriptorRefs>
                    </configuration>
                    <executions>
                        <execution>
                            <id>attach-dependencies</id>
                            <phase>package</phase>
                            <goals>
                                <goal>single</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                <plugin>
                    <groupId>org.apache.tomcat.maven</groupId>
                    <artifactId>tomcat7-maven-plugin</artifactId>
                    <version>2.2</version>
                    <configuration>
                        <path><#noparse>${project.web.basePath}</#noparse></path>
                        <port>8080</port>
                        <uriEncoding>UTF-8</uriEncoding>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.eclipse.jetty</groupId>
                    <artifactId>jetty-maven-plugin</artifactId>
                    <version>9.2.21.v20170120</version>
                    <configuration>
                        <stopPort>9966</stopPort>
                        <stopKey>foo</stopKey>
                        <scanIntervalSeconds>10</scanIntervalSeconds>
                        <webApp>
                            <contextPath><#noparse>${project.web.basePath}</#noparse></contextPath>
                        </webApp>
                        <httpConnector>
                            <port>8080</port>
                        </httpConnector>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
            </plugin>
            <!--
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
            </plugin>
            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
            </plugin>
            -->
        </plugins>
    </build>
    <reporting>
        <outputDirectory>target/report</outputDirectory>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version><#noparse>${maven-javadoc-plugin.version}</#noparse></version>
            </plugin>
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>findbugs-maven-plugin</artifactId>
                <version><#noparse>${findbugs-maven-plugin.version}</#noparse></version>
            </plugin>
        </plugins>
    </reporting>
    <dependencyManagement>
        <dependencies>
        <#if spring_viewresolver?lower_case?trim == 'velocity'>
            <dependency>
                <groupId>org.apache.velocity</groupId>
                <artifactId>velocity</artifactId>
                <version><#noparse>${velocity.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>velocity</groupId>
                <artifactId>velocity-dep</artifactId>
                <version><#noparse>${velocity-dep.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.apache.velocity</groupId>
                <artifactId>velocity-tools</artifactId>
                <version><#noparse>${velocity-tools.version}</#noparse></version>
            </dependency>
        </#if>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version><#noparse>${dependency.junit.version}</#noparse></version>
                <scope>test</scope>
            </dependency>
            <!-- logging BEGIN-->
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-api</artifactId>
                <version>1.7.7</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-core</artifactId>
                <version>${logback.version}</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-access</artifactId>
                <version>${logback.version}</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-classic</artifactId>
                <version>${logback.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-logging</groupId>
                <artifactId>commons-logging</artifactId>
                <version>1.1.3</version>
            </dependency>
            <dependency>
                <groupId>org.apache.commons</groupId>
                <artifactId>commons-pool2</artifactId>
                <version>2.4.2</version>
            </dependency>
            <dependency>
                <groupId>org.apache.commons</groupId>
                <artifactId>commons-lang3</artifactId>
                <version>3.3.2</version>
            </dependency>
            <dependency>
                <groupId>commons-fileupload</groupId>
                <artifactId>commons-fileupload</artifactId>
                <version>1.3.1</version>
            </dependency>
            <dependency>
                <groupId>com.squareup.okhttp3</groupId>
                <artifactId>okhttp</artifactId>
                <version>3.3.1</version>
            </dependency>
            <dependency>
                <groupId>com.thoughtworks.xstream</groupId>
                <artifactId>xstream</artifactId>
                <version>1.4.8</version>
            </dependency>
            <!-- spring -->
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-beans</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-web</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-webmvc</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-tx</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-jdbc</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-jms</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-orm</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-oxm</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-core</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context-support</artifactId>
                <version><#noparse>${spring.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>cglib</groupId>
                <artifactId>cglib</artifactId>
                <version>3.1</version>
            </dependency>
            <dependency>
                <groupId>com.google.guava</groupId>
                <artifactId>guava</artifactId>
                <version>19.0</version>
            </dependency>
            <!-- url rewrite -->
            <dependency>
                <groupId>org.tuckey</groupId>
                <artifactId>urlrewritefilter</artifactId>
                <version>4.0.4</version>
            </dependency>
        <#if support_mongoDB == "true">
            <!-- mongodb & spring -->
            <dependency>
                <groupId>org.mongodb</groupId>
                <artifactId>mongo-java-driver</artifactId>
                <version>2.14.3</version>
            </dependency>
            <dependency>
                <groupId>org.springframework.data</groupId>
                <artifactId>spring-data-mongodb</artifactId>
                <version>1.5.6.RELEASE</version>
                <exclusions>
                    <exclusion>
                        <groupId>org.springframework</groupId>
                        <artifactId>spring-expression</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
        </#if>
        <#if support_Redis == "true">
            <!-- redis & spring -->
            <dependency>
                <groupId>org.springframework.data</groupId>
                <artifactId>spring-data-redis</artifactId>
                <version>1.6.4.RELEASE</version>
                <exclusions>
                    <exclusion>
                        <groupId>org.springframework</groupId>
                        <artifactId>spring-aop</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
            <dependency>
                <groupId>redis.clients</groupId>
                <artifactId>jedis</artifactId>
                <version>2.7.3</version>
            </dependency>
        </#if>
        <#if support_Dubbo == "true">
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>dubbo</artifactId>
                <version><#noparse>${dubbo.version}</#noparse></version>
                <exclusions>
                    <exclusion>
                        <groupId>org.springframework</groupId>
                        <artifactId>spring</artifactId>
                    </exclusion>
                    <exclusion>
                        <groupId>log4j</groupId>
                        <artifactId>log4j</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
            <dependency>
                <groupId>com.101tec</groupId>
                <artifactId>zkclient</artifactId>
                <version><#noparse>${zkclient.version}</#noparse></version>
                <exclusions>
                    <exclusion>
                        <groupId>org.slf4j</groupId>
                        <artifactId>slf4j-log4j12</artifactId>
                    </exclusion>
                    <exclusion>
                        <groupId>log4j</groupId>
                        <artifactId>log4j</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
        </#if>
        <#if support_Shiro == "true">
            <!-- shiro-web -->
            <dependency>
                <groupId>org.apache.shiro</groupId>
                <artifactId>shiro-web</artifactId>
                <version><#noparse>${shiro.version}</#noparse></version>
            </dependency>
            <!-- shiro-spring -->
            <dependency>
                <groupId>org.apache.shiro</groupId>
                <artifactId>shiro-spring</artifactId>
                <version><#noparse>${shiro.version}</#noparse></version>
            </dependency>
            <!-- shiro-ehcache -->
            <dependency>
                <groupId>org.apache.shiro</groupId>
                <artifactId>shiro-ehcache</artifactId>
                <version><#noparse>${shiro.version}</#noparse></version>
            </dependency>
        </#if>
            <!-- Validator -->
            <dependency>
                <groupId>javax.validation</groupId>
                <artifactId>validation-api</artifactId>
                <version><#noparse>${javax.validation.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-validator</artifactId>
                <version><#noparse>${hibernate.validator.version}</#noparse></version>
            </dependency>
            <!-- drivers & middle ware -->
            <dependency>
                <groupId>com.jolbox</groupId>
                <artifactId>bonecp-spring</artifactId>
                <version><#noparse>${bonecp.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>com.jolbox</groupId>
                <artifactId>bonecp-provider</artifactId>
                <version>0.8.0-alpha1</version>
            </dependency>
            <dependency>
                <groupId>com.jolbox</groupId>
                <artifactId>bonecp</artifactId>
                <version><#noparse>${bonecp.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.mariadb.jdbc</groupId>
                <artifactId>mariadb-java-client</artifactId>
                <version>1.2.0</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis</artifactId>
                <version>3.2.2</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis-spring</artifactId>
                <version>1.2.0</version>
            </dependency>
            <dependency>
                <groupId>org.codehaus.jackson</groupId>
                <artifactId>jackson-mapper-asl</artifactId>
                <version>1.9.12</version>
            </dependency>
            <dependency>
                <groupId>com.fasterxml.jackson.core</groupId>
                <artifactId>jackson-databind</artifactId>
                <version><#noparse>${fasterxml.jackson.databind.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>com.fasterxml.jackson.dataformat</groupId>
                <artifactId>jackson-dataformat-xml</artifactId>
                <version><#noparse>${fasterxml.jackson.databind.version}</#noparse></version>
            </dependency>
            <!-- container -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>javax.servlet-api</artifactId>
                <version><#noparse>${servlet.api.version}</#noparse></version>
                <scope>provided</scope>
            </dependency>
            <dependency>
                <groupId>javax.el</groupId>
                <artifactId>javax.el-api</artifactId>
                <version><#noparse>${javax.el.version}</#noparse></version>
                <scope>provided</scope>
            </dependency>
            <dependency>
                <groupId>org.aspectj</groupId>
                <artifactId>aspectjrt</artifactId>
                <version><#noparse>${org.aspectj.version}</#noparse></version>
            </dependency>
            <dependency>
                <groupId>org.aspectj</groupId>
                <artifactId>aspectjweaver</artifactId>
                <version><#noparse>${org.aspectj.version}</#noparse></version>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <dependencies>

        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
        </dependency>
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
        </dependency>
        <!-- logging BEGIN-->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-core</artifactId>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-access</artifactId>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-pool2</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>
        <dependency>
            <groupId>com.thoughtworks.xstream</groupId>
            <artifactId>xstream</artifactId>
        </dependency>
        <!-- spring -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-beans</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-tx</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jms</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-orm</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-oxm</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context-support</artifactId>
        </dependency>
        <dependency>
            <groupId>cglib</groupId>
            <artifactId>cglib</artifactId>
        </dependency>
        <dependency>
            <groupId>org.codehaus.jackson</groupId>
            <artifactId>jackson-mapper-asl</artifactId>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.dataformat</groupId>
            <artifactId>jackson-dataformat-xml</artifactId>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjrt</artifactId>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
        </dependency>
        <dependency>
            <groupId>com.squareup.okhttp3</groupId>
            <artifactId>okhttp</artifactId>
        </dependency>
    <#if support_Shiro == "true">
        <!-- shiro-spring -->
        <dependency>
            <groupId>org.apache.shiro</groupId>
            <artifactId>shiro-spring</artifactId>
        </dependency>
        <!-- shiro-ehcache -->
        <dependency>
            <groupId>org.apache.shiro</groupId>
            <artifactId>shiro-ehcache</artifactId>
        </dependency>
    </#if>
    </dependencies>

    <profiles>
        <profile>
            <id>Dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <profile-name>Dev</profile-name>
                <!--Log Configuration-->
                <catalina.base>target</catalina.base>
                <catalina.log.priority>INFO</catalina.log.priority>
            </properties>
        </profile>
        <profile>
            <id>Pro</id>
            <properties>
                <profile-name>Pro</profile-name>
                <!--Log Configuration-->
                <catalina.base>~/apps</catalina.base>
                <catalina.log.priority>WARN</catalina.log.priority>
            </properties>
        </profile>
    </profiles>
</project>
