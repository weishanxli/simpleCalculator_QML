#include "Calculator.h"
#include <QDebug>
#include <QString>

Calculator::Calculator(QObject *parent)
    : QObject{parent}
{

}

void Calculator::evaluate(QString n2, QString operation)
{
    float result = 0;
    m_operand2 = n2.toFloat();
    if (operation == "+")
    {
        result = m_operand1 + m_operand2;
    }
    else if (operation == "-")
    {
        result = m_operand1 - m_operand2;
    }
    else if (operation == "x")
    {
        result = m_operand1 * m_operand2;
    }
    else if (operation == "÷")
    {
        result = m_operand1 / m_operand2;
    }
    else
    {
        // Invalid / unknown operation
        return;
    }
    emit resultCalculated(QString::number(result));
    m_operand1 = result;
}

void Calculator::setFirstOperand(QString n1)
{
    m_operand1 = n1.toFloat();
}

void Calculator::setInputAsPercent(QString n)
{
    // Convert from percentage
    if (n == "")
    {
        return;
    }
    float percent = n.toFloat() / 100.0f;
    emit inputSetAsPercent(QString::number(percent));
}

void Calculator::toggleSign(QString n)
{
    // Toggle negative/positive
    if (n == "")
    {
        return;
    }
    float n_toggled = n.toFloat() * -1.0f;
    emit inputSignToggled(QString::number(n_toggled));
}
