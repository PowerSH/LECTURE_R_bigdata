### 지도 관련 패키지 설치 및 불러오기
# + 공간 지도 분석을 위한 패키지
# - maps: 세계 지도 데이터베이스
# - mapproj: 지도 상에 위도와 경도를 표시
# - ggplot2: map_data()를 이용하여 지도정보를 R로 불러오기
# - ggiraphExtra : 단계 구분도 표시

install.packages("maps")
install.packages("mapproj")
install.packages("ggplot2")
install.packages("ggiraphExtra")

library(maps)
library(mapproj)
library(ggplot2)
library(ggiraphExtra)

kangwon_air_201904 <- read.csv("kangwon_air_201904.csv")
kangwon_air_201904 <- rename(kangwon_air_201904,
                             city = 시군,
                             station = 측정소)

kangwon_map <- read.csv("kangwon_map.csv")
kangwon_map <- kormap2 %>% filter(str_starts(region, "32"))
#map('korea_map', region=c('32'))


ggChoropleth(data = kangwon_air_201904,     # 지도에 표현할 데이터
             mapping=aes(fill = PM2.5,        # 색깔로 표현할 변수
                         map_id = region, # 지역 기준 변수, region
                         tooltip = name),  # 지도 위에 표시할 지역명
             title = "강원도 2019년 4월 미세먼지 PM2.5 분포",
             map = kangwon_map,             # 지도 데이터
             interactive = T)    


ggplot(kangwon_air_201904,aes(map_id=region,fill=PM2.5))+
  geom_map(map=kangwon_map,colour="black",size=0.1)+
  expand_limits(x=kangwon_map$long,y=kormap1$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()

