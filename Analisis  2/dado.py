import random
x=5
lista=["Cesar","Nat","Carlos_M","Iago","Carlos"]

while len(lista)!= 0:
    cont=len(lista)
    jug=random.randint(0,cont-1)
    y=lista.pop(jug)
    dia=(random.randint(1,5))
    print("A el esculta:",y, "\nle toca el sector",dia)

print(lista)