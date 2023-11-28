#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include <QtQml>

class Calculator : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Calculator(QObject *parent = nullptr);
    Q_INVOKABLE void evaluate(QString n2, QString operation);
    Q_INVOKABLE void setFirstOperand(QString n1);
    Q_INVOKABLE void setInputAsPercent(QString n);
    Q_INVOKABLE void toggleSign(QString n);
signals:
    void resultCalculated(QString num);
    void inputSetAsPercent(QString num);
    void inputSignToggled(QString num);

private:
    float m_operand1 = 0;
    float m_operand2 = 0;
};

#endif // CALCULATOR_H
