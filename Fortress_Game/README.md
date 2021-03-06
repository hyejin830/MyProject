Matlab을 활용한 GUI 포트리스 게임
=====================

Github : https://github.com/hyejin830/Fortress_Game

Description
------------
2명의 유저를 선택하여 포트리스 게임을 할 수 있는 프로그램입니다.

Period
-------
2017.12-2018.01 ( 약 1개월 ) 

Release
-------
x

Role
----
개인 프로젝트 

Language
---------
Matlab

Tool
-----
Matlab 

Develop
-------
1. 내부 DB 연동
 - 플레이어 정보(이름, 이긴 횟수, 진 횟수, 총 점수)
2. 게임 중앙에 게임 보드 출력 
 - 두 플레이어의 초기 x, y값 무작위로 부여
 - 보드의 x 범위 : 0~200이고 0~100은 플레이어1/ 100~200은 플레이어 2
2. 플레이어의 마우스 입력 값에 따라 x, y좌표, 각도, 속도 설정 Interface 구현
 - 버튼, 슬라이드 바
3. 날아가는 모션 구현(애니메이션)
 - ‘포물선 운동’ 이론 적용
 - 회전각을 활용한 애니메이션 구현
4. 게임 순서와 규칙 명확하게 작성 후 문서화

UI
---

<img src="./images/1.JPG" width="400" height="250"> | <img src="./images/2.JPG" width="400" height="250">


<img src="./images/3.JPG" width="400" height="250"> | <img src="./images/4.JPG" width="400" height="250">


<img src="./images/5.JPG" width="400" height="250"> | <img src="./images/6.JPG" width="400" height="250">


<img src="./images/7.jpg" width="400" height="250"> | <img src="./images/8.JPG" width="400" height="250">


Testing
-----
[![Watch the video](https://img.youtube.com/vi/MHSnb30xtmE/maxresdefault.jpg)](https://youtu.be/MHSnb30xtmE)
